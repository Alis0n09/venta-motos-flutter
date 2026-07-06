// lib/domain/model/proveedor_state.dart

import 'proveedor.dart';

class ProveedorState {
  final List<Proveedor> proveedores;
  final bool isLoading;
  final String? error;
  final String search;
  final String? paisSeleccionado; // null = todos

  const ProveedorState({
    this.proveedores = const [],
    this.isLoading = false,
    this.error,
    this.search = '',
    this.paisSeleccionado,
  });

  ProveedorState copyWith({
    List<Proveedor>? proveedores,
    bool? isLoading,
    String? error,
    String? search,
    String? paisSeleccionado,
    bool clearPais = false,
  }) {
    return ProveedorState(
      proveedores: proveedores ?? this.proveedores,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      search: search ?? this.search,
      paisSeleccionado: clearPais ? null : (paisSeleccionado ?? this.paisSeleccionado),
    );
  }
}
