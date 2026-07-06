// lib/presentation/providers/compra_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/compra_remote_datasource.dart';
import '../../domain/model/compra_state.dart';

class CompraNotifier extends StateNotifier<CompraState> {
  final CompraRemoteDatasource _datasource;

  CompraNotifier(this._datasource) : super(const CompraState()) {
    loadCompras();
  }

  Future<void> loadCompras() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final compras = await _datasource.getCompras(
        proveedor: state.proveedorSeleccionado,
        sucursalDestino: state.sucursalSeleccionada,
      );
      state = state.copyWith(compras: compras, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar las compras.');
    }
  }

  void filtrarPorProveedor(int? proveedorId) {
    if (proveedorId == null) {
      state = state.copyWith(clearProveedor: true);
    } else {
      state = state.copyWith(proveedorSeleccionado: proveedorId);
    }
    loadCompras();
  }

  void filtrarPorSucursal(int? sucursalId) {
    if (sucursalId == null) {
      state = state.copyWith(clearSucursal: true);
    } else {
      state = state.copyWith(sucursalSeleccionada: sucursalId);
    }
    loadCompras();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(clearProveedor: true, clearSucursal: true);
    return loadCompras();
  }
}

final compraProvider = StateNotifierProvider.autoDispose<CompraNotifier, CompraState>((ref) {
  return CompraNotifier(ref.watch(compraDatasourceProvider));
});
