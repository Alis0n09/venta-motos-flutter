// lib/presentation/providers/catalog_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/categoria_remote_datasource.dart';
import '../../data/remote/api/marca_remote_datasource.dart';
import '../../data/remote/api/moto_remote_datasource.dart';
import '../../domain/model/catalog_state.dart';
import '../../domain/model/categoria.dart';
import '../../domain/model/marca.dart';
import '../../domain/model/moto.dart';


final marcasProvider = FutureProvider<List<Marca>>((ref) async {
  final datasource = ref.watch(marcaDatasourceProvider);
  return datasource.getMarcas();
});

final categoriasProvider = FutureProvider<List<Categoria>>((ref) async {
  final datasource = ref.watch(categoriaDatasourceProvider);
  return datasource.getCategorias();
});

final recomendadasProvider = FutureProvider<List<Moto>>((ref) async {
  final datasource = ref.watch(motoDatasourceProvider);
  return datasource.getMotos();
});

class CatalogNotifier extends StateNotifier<CatalogState> {
  final MotoRemoteDatasource _datasource;

  CatalogNotifier(this._datasource) : super(const CatalogState()) {
    loadMotos();
  }

  Future<void> loadMotos() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final motos = await _datasource.getMotos(
        marcaId: state.marcaSeleccionada,
        search: state.search,
      );
      state = state.copyWith(motos: motos, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar el catálogo.');
    }
  }

  void seleccionarMarca(int? marcaId) {
    if (marcaId == null) {
      state = state.copyWith(clearMarca: true);
    } else {
      state = state.copyWith(marcaSeleccionada: marcaId);
    }
    loadMotos();
  }

  void buscar(String texto) {
    state = state.copyWith(search: texto);
    loadMotos();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(clearMarca: true, search: '');
    return loadMotos();
  }
}

final catalogProvider = StateNotifierProvider<CatalogNotifier, CatalogState>((ref) {
  return CatalogNotifier(ref.watch(motoDatasourceProvider));
});


final motoDetailProvider = FutureProvider.family<Moto, int>((ref, id) async {
  final datasource = ref.watch(motoDatasourceProvider);
  return datasource.getMoto(id);
});