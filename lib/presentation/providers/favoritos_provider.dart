// lib/presentation/providers/favoritos_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/favoritos_storage.dart';
import '../../data/remote/api/moto_remote_datasource.dart';
import '../../domain/model/moto.dart';

class FavoritosNotifier extends StateNotifier<Set<int>> {
  final FavoritosStorage _storage;

  FavoritosNotifier(this._storage) : super(const {}) {
    _cargar();
  }

  Future<void> _cargar() async {
    state = await _storage.getFavoritos();
  }

  Future<void> toggle(int motoId) async {
    final nuevo = Set<int>.from(state);
    if (!nuevo.remove(motoId)) {
      nuevo.add(motoId);
    }
    state = nuevo;
    await _storage.saveFavoritos(nuevo);
  }

  bool esFavorito(int motoId) => state.contains(motoId);
}

final favoritosProvider = StateNotifierProvider<FavoritosNotifier, Set<int>>((ref) {
  return FavoritosNotifier(ref.watch(favoritosStorageProvider));
});

/// Resuelve los ids favoritos a objetos Moto completos, para pintar la pantalla de favoritos.
final favoritosMotosProvider = FutureProvider.autoDispose<List<Moto>>((ref) async {
  final ids = ref.watch(favoritosProvider);
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