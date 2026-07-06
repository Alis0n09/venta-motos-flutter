// lib/presentation/providers/proveedor_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/proveedor_remote_datasource.dart';
import '../../domain/model/proveedor_state.dart';

class ProveedorNotifier extends StateNotifier<ProveedorState> {
  final ProveedorRemoteDatasource _datasource;

  ProveedorNotifier(this._datasource) : super(const ProveedorState()) {
    loadProveedores();
  }

  Future<void> loadProveedores() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final proveedores = await _datasource.getProveedores(
        search: state.search,
        pais: state.paisSeleccionado,
      );
      if (!mounted) return;
      state = state.copyWith(proveedores: proveedores, isLoading: false);
    } on ApiException catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar los proveedores.');
    }
  }

  void buscar(String texto) {
    state = state.copyWith(search: texto);
    loadProveedores();
  }

  void filtrarPorPais(String? pais) {
    if (pais == null) {
      state = state.copyWith(clearPais: true);
    } else {
      state = state.copyWith(paisSeleccionado: pais);
    }
    loadProveedores();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(search: '', clearPais: true);
    return loadProveedores();
  }
}

final proveedorProvider = StateNotifierProvider.autoDispose<ProveedorNotifier, ProveedorState>((ref) {
  return ProveedorNotifier(ref.watch(proveedorDatasourceProvider));
});
