// lib/domain/model/sucursal_staff_state.dart

import 'sucursal_staff.dart';

// El backend de sucursal-staff no expone un filtro "search" (solo staff, sucursal,
// fecha_asignacion), así que el buscador de la pantalla filtra localmente sobre
// `asignaciones` en vez de mandar un query param que el backend ignoraría.
class SucursalStaffState {
  final List<SucursalStaff> asignaciones;
  final bool isLoading;
  final String? error;
  final int? sucursalSeleccionada; // null = todas

  const SucursalStaffState({
    this.asignaciones = const [],
    this.isLoading = false,
    this.error,
    this.sucursalSeleccionada,
  });

  SucursalStaffState copyWith({
    List<SucursalStaff>? asignaciones,
    bool? isLoading,
    String? error,
    int? sucursalSeleccionada,
    bool clearSucursal = false,
  }) {
    return SucursalStaffState(
      asignaciones: asignaciones ?? this.asignaciones,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sucursalSeleccionada: clearSucursal ? null : (sucursalSeleccionada ?? this.sucursalSeleccionada),
    );
  }
}
