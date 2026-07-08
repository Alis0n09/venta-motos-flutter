// lib/presentation/providers/favoritos_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/favoritos_storage.dart';
import '../../data/remote/api/moto_remote_datasource.dart';
import '../../domain/model/moto.dart';
import 'auth_provider.dart';

class FavoritosNotifier extends StateNotifier<Set<int>> {
  final FavoritosStorage _storage;
  final int? _userId;

  /// [userId] es `null` cuando no hay sesión iniciada. En ese caso los
  /// favoritos quedan deshabilitados por completo (no se cargan ni se
  /// pueden agregar), en vez de guardarse sueltos en el dispositivo.
  FavoritosNotifier(this._storage, this._userId) : super(const {}) {
    _cargar();
  }

  Future<void> _cargar() async {
    if (_userId == null) {
      state = const {};
      return;
    }
    state = await _storage.getFavoritos(_userId);
  }

  Future<void> toggle(int motoId) async {
    // Sin sesión iniciada no hay dónde guardar el favorito de forma segura
    // (no se sabe de quién es), así que no hace nada.
    if (_userId == null) return;

    final nuevo = Set<int>.from(state);
    if (!nuevo.remove(motoId)) {
      nuevo.add(motoId);
    }
    state = nuevo;
    await _storage.saveFavoritos(_userId, nuevo);
  }

  bool esFavorito(int motoId) => state.contains(motoId);
}

/// Se reconstruye automáticamente cuando cambia la sesión (login, logout,
/// u otra cuenta en el mismo dispositivo), porque observa `authProvider`.
/// Disponible para cualquier usuario logueado (cliente o staff/admin);
/// solo se deshabilita para quien no tiene sesión iniciada.
final favoritosProvider = StateNotifierProvider<FavoritosNotifier, Set<int>>((ref) {
  final authState = ref.watch(authProvider);
  final userId = authState.isAuthenticated ? authState.user?.id : null;
  return FavoritosNotifier(ref.watch(favoritosStorageProvider), userId);
});

/// Resuelve los ids favoritos a objetos Moto completos, para pintar la
/// pantalla de favoritos. Vacío si no hay sesión iniciada.
final favoritosMotosProvider = FutureProvider.autoDispose<List<Moto>>((ref) async {
  final ids = ref.watch(favoritosProvider);
  if (ids.isEmpty) return [];

  final datasource = ref.watch(motoDatasourceProvider);
  final motos = <Moto>[];
  for (final id in ids) {
    try {
      motos.add(await datasource.getMoto(id));
    } catch (_) {
      // La moto pudo haber sido eliminada del catálogo; se ignora silenciosamente.
    }
  }
  return motos;
});