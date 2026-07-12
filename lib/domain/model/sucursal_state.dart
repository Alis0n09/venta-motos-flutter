// lib/domain/model/sucursal_state.dart

import 'sucursal.dart';

class SucursalState {
  final List<Sucursal> sucursales;
  final bool isLoading;
  final String? error;
  final String search;
  final String? ciudadSeleccionada; // null = todas

  const SucursalState({
    this.sucursales = const [],
    this.isLoading = false,
    this.error,
    this.search = '',
    this.ciudadSeleccionada,
  });

  SucursalState copyWith({
    List<Sucursal>? sucursales,
    bool? isLoading,
    String? error,
    String? search,
    String? ciudadSeleccionada,
    bool clearCiudad = false,
  }) {
    return SucursalState(
      sucursales: sucursales ?? this.sucursales,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      search: search ?? this.search,
      ciudadSeleccionada: clearCiudad ? null : (ciudadSeleccionada ?? this.ciudadSeleccionada),
    );
  }
}
