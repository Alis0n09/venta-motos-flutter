// lib/presentation/providers/perfil_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/perfil_remote_datasource.dart';
import '../../domain/model/perfil.dart';

final perfilCuentaProvider = FutureProvider<PerfilCuenta>((ref) async {
  final datasource = ref.watch(perfilDatasourceProvider);
  return datasource.getCuenta();
});

final perfilClienteProvider = FutureProvider<PerfilCliente>((ref) async {
  final datasource = ref.watch(perfilDatasourceProvider);
  return datasource.getCliente();
});

class PerfilNotifier extends StateNotifier<AsyncValue<void>> {
  final PerfilRemoteDatasource _datasource;
  final Ref _ref;

  PerfilNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> guardarCuenta(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateCuenta(payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(perfilCuentaProvider);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }

  Future<bool> guardarCliente(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateCliente(payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(perfilClienteProvider);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }

  Future<bool> cambiarPassword({
    required String currentPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.cambiarPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPassword2: newPassword2,
      );
      state = const AsyncValue.data(null);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }
}

final perfilNotifierProvider = StateNotifierProvider<PerfilNotifier, AsyncValue<void>>((ref) {
  return PerfilNotifier(ref.watch(perfilDatasourceProvider), ref);
});