// lib/domain/model/compra_state.dart

import 'compra.dart';

class CompraState {
  final List<Compra> compras;
  final bool isLoading;
  final String? error;
  final int? proveedorSeleccionado; // null = todos
  final int? sucursalSeleccionada; // null = todas

  const CompraState({
    this.compras = const [],
    this.isLoading = false,
    this.error,
    this.proveedorSeleccionado,
    this.sucursalSeleccionada,
  });

  CompraState copyWith({
    List<Compra>? compras,
    bool? isLoading,
    String? error,
    int? proveedorSeleccionado,
    bool clearProveedor = false,
    int? sucursalSeleccionada,
    bool clearSucursal = false,
  }) {
    return CompraState(
      compras: compras ?? this.compras,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      proveedorSeleccionado: clearProveedor ? null : (proveedorSeleccionado ?? this.proveedorSeleccionado),
      sucursalSeleccionada: clearSucursal ? null : (sucursalSeleccionada ?? this.sucursalSeleccionada),
    );
  }
}
