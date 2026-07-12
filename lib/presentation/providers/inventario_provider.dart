// lib/presentation/providers/inventario_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/inventario_remote_datasource.dart';
import '../../domain/model/inventario.dart';
import '../../domain/model/inventario_state.dart';

class InventarioNotifier extends StateNotifier<InventarioState> {
  final InventarioRemoteDatasource _datasource;

  InventarioNotifier(this._datasource) : super(const InventarioState()) {
    loadInventarios();
  }

  Future<void> loadInventarios() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final inventarios = await _datasource.getInventarios(
        moto: state.motoSeleccionada,
        sucursal: state.sucursalSeleccionada,
        cantidadMin: state.cantidadMin,
        cantidadMax: state.cantidadMax,
        search: state.search,
      );
      if (!mounted) return;
      state = state.copyWith(inventarios: inventarios, isLoading: false);
    } on ApiException catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar el inventario.');
    }
  }

  void filtrarPorMoto(int? motoId) {
    if (motoId == null) {
      state = state.copyWith(clearMoto: true);
    } else {
      state = state.copyWith(motoSeleccionada: motoId);
    }
    loadInventarios();
  }

  void filtrarPorSucursal(int? sucursalId) {
    if (sucursalId == null) {
      state = state.copyWith(clearSucursal: true);
    } else {
      state = state.copyWith(sucursalSeleccionada: sucursalId);
    }
    loadInventarios();
  }

  void filtrarPorCantidad({int? min, int? max}) {
    state = state.copyWith(
      cantidadMin: min,
      clearCantidadMin: min == null,
      cantidadMax: max,
      clearCantidadMax: max == null,
    );
    loadInventarios();
  }

  void buscar(String texto) {
    state = state.copyWith(search: texto);
    loadInventarios();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(
      clearMoto: true,
      clearSucursal: true,
      clearCantidadMin: true,
      clearCantidadMax: true,
      search: '',
    );
    return loadInventarios();
  }
}

final inventarioProvider =
    StateNotifierProvider.autoDispose<InventarioNotifier, InventarioState>((ref) {
  return InventarioNotifier(ref.watch(inventarioDatasourceProvider));
});

/// Desglose de los registros reales de Inventario de una Moto puntual, uno
/// por sucursal. Usado en el modo "Todas las sucursales" de InventarioListScreen
/// para mostrar el detalle detrás del stock agregado.
final desgloseInventarioProvider =
    FutureProvider.autoDispose.family<List<Inventario>, int>((ref, motoId) async {
  final datasource = ref.watch(inventarioDatasourceProvider);
  return datasource.getInventarios(moto: motoId);
});
