// lib/presentation/providers/sucursal_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/sucursal_remote_datasource.dart';
import '../../domain/model/sucursal.dart';
import '../../domain/model/sucursal_state.dart';

// Lista sin filtrar, usada solo para poblar el selector de ciudades.
final sucursalesTodasProvider = FutureProvider.autoDispose<List<Sucursal>>((ref) async {
  final datasource = ref.watch(sucursalDatasourceProvider);
  return datasource.getSucursales();
});

class SucursalNotifier extends StateNotifier<SucursalState> {
  final SucursalRemoteDatasource _datasource;

  SucursalNotifier(this._datasource) : super(const SucursalState()) {
    loadSucursales();
  }

  Future<void> loadSucursales() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final sucursales = await _datasource.getSucursales(
        search: state.search,
        ciudad: state.ciudadSeleccionada,
      );
      state = state.copyWith(sucursales: sucursales, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar las sucursales.');
    }
  }

  void buscar(String texto) {
    state = state.copyWith(search: texto);
    loadSucursales();
  }

  void filtrarPorCiudad(String? ciudad) {
    if (ciudad == null) {
      state = state.copyWith(clearCiudad: true);
    } else {
      state = state.copyWith(ciudadSeleccionada: ciudad);
    }
    loadSucursales();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(search: '', clearCiudad: true);
    return loadSucursales();
  }
}

final sucursalProvider = StateNotifierProvider.autoDispose<SucursalNotifier, SucursalState>((ref) {
  return SucursalNotifier(ref.watch(sucursalDatasourceProvider));
});
