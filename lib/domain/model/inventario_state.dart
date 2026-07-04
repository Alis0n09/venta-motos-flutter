// lib/domain/model/inventario_state.dart

import 'inventario.dart';

class InventarioState {
  final List<Inventario> inventarios;
  final bool isLoading;
  final String? error;
  final int? motoSeleccionada; // null = todas
  final int? sucursalSeleccionada; // null = todas
  final int? cantidadMin;
  final int? cantidadMax;
  final String search;

  const InventarioState({
    this.inventarios = const [],
    this.isLoading = false,
    this.error,
    this.motoSeleccionada,
    this.sucursalSeleccionada,
    this.cantidadMin,
    this.cantidadMax,
    this.search = '',
  });

  InventarioState copyWith({
    List<Inventario>? inventarios,
    bool? isLoading,
    String? error,
    int? motoSeleccionada,
    bool clearMoto = false,
    int? sucursalSeleccionada,
    bool clearSucursal = false,
    int? cantidadMin,
    bool clearCantidadMin = false,
    int? cantidadMax,
    bool clearCantidadMax = false,
    String? search,
  }) {
    return InventarioState(
      inventarios: inventarios ?? this.inventarios,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      motoSeleccionada: clearMoto ? null : (motoSeleccionada ?? this.motoSeleccionada),
      sucursalSeleccionada:
          clearSucursal ? null : (sucursalSeleccionada ?? this.sucursalSeleccionada),
      cantidadMin: clearCantidadMin ? null : (cantidadMin ?? this.cantidadMin),
      cantidadMax: clearCantidadMax ? null : (cantidadMax ?? this.cantidadMax),
      search: search ?? this.search,
    );
  }
}
