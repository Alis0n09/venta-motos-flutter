// lib/presentation/providers/sucursal_staff_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/sucursal_staff_remote_datasource.dart';
import '../../domain/model/sucursal_staff_state.dart';

class SucursalStaffNotifier extends StateNotifier<SucursalStaffState> {
  final SucursalStaffRemoteDatasource _datasource;

  SucursalStaffNotifier(this._datasource) : super(const SucursalStaffState()) {
    loadAsignaciones();
  }

  Future<void> loadAsignaciones() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final asignaciones = await _datasource.getSucursalStaff(
        sucursal: state.sucursalSeleccionada,
      );
      state = state.copyWith(asignaciones: asignaciones, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar las asignaciones.');
    }
  }

  void filtrarPorSucursal(int? sucursalId) {
    if (sucursalId == null) {
      state = state.copyWith(clearSucursal: true);
    } else {
      state = state.copyWith(sucursalSeleccionada: sucursalId);
    }
    loadAsignaciones();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(clearSucursal: true);
    return loadAsignaciones();
  }
}

final sucursalStaffProvider =
    StateNotifierProvider.autoDispose<SucursalStaffNotifier, SucursalStaffState>((ref) {
  return SucursalStaffNotifier(ref.watch(sucursalStaffDatasourceProvider));
});
