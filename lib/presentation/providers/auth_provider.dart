// lib/presentation/providers/auth_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/local/secure_storage.dart';
import '../../data/remote/api/auth_remote_datasource.dart';
import '../../domain/model/auth_models.dart';
import '../../domain/model/auth_state.dart';
import 'perfil_provider.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRemoteDatasource _datasource;
  final SecureStorage _storage;
  final Ref _ref;

  AuthNotifier(this._datasource, this._storage, this._ref) : super(const AuthState.checking()) {
    _restoreSession();
  }

  void _limpiarCachesDePerfil() {
    _ref.invalidate(perfilCuentaProvider);
    _ref.invalidate(perfilClienteProvider);
  }

  Future<void> _restoreSession() async {
    try {
      final isLoggedIn = await _storage.isLoggedIn();
      if (!isLoggedIn) {
        state = const AuthState.unauthenticated();
        return;
      }

      final userData = await _storage.getUser();
      if (userData == null) {
        state = const AuthState.unauthenticated();
        return;
      }

      final rolGuardado = userData['rol'];
      final rol = (rolGuardado == null || rolGuardado.isEmpty) ? null : rolGuardado;

      final user = LoggedUser(
        id: int.parse(userData['id']!),
        username: userData['username']!,
        email: userData['email']!,
        isStaff: userData['is_staff'] == 'true',
        rol: rol,
      );
      state = AuthState.authenticated(user);
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String username, String password) async {
    state = const AuthState.checking();
    try {
      final user = await _datasource.login(username.trim(), password);
      _limpiarCachesDePerfil();
      state = AuthState.authenticated(user);
    } on ApiException catch (e) {
      state = AuthState.unauthenticated(e.message);
    } catch (e) {
      state = const AuthState.unauthenticated('Error inesperado. Intenta de nuevo.');
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String password2,
    required String nombre,
    required String apellido,
    required String cedula,
    String? telefono,
  }) async {
    state = const AuthState.checking();
    try {
      final user = await _datasource.register(
        username: username.trim(),
        email: email.trim(),
        password: password,
        password2: password2,
        nombre: nombre.trim(),
        apellido: apellido.trim(),
        cedula: cedula.trim(),
        telefono: telefono,
      );
      _limpiarCachesDePerfil();
      state = AuthState.authenticated(user);
    } on ApiException catch (e) {
      state = AuthState.unauthenticated(e.message);
    } catch (e) {
      state = const AuthState.unauthenticated('Error inesperado. Intenta de nuevo.');
    }
  }

  Future<void> logout() async {
    await _datasource.logout();
    _limpiarCachesDePerfil();
    state = const AuthState.unauthenticated();
  }

  void clearError() {
    if (state.isUnauthenticated && state.error != null) {
      state = const AuthState.unauthenticated();
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authDatasourceProvider),
    ref.watch(secureStorageProvider),
    ref,
  );
});