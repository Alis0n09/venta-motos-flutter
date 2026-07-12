// lib/domain/model/direccion_state.dart

import 'direccion.dart';

class DireccionState {
  final List<Direccion> direcciones;
  final bool isLoading;
  final String? error;
  final String search;
  final String? ciudadSeleccionada; // null = todas
  final String? provinciaSeleccionada; // null = todas

  const DireccionState({
    this.direcciones = const [],
    this.isLoading = false,
    this.error,
    this.search = '',
    this.ciudadSeleccionada,
    this.provinciaSeleccionada,
  });

  DireccionState copyWith({
    List<Direccion>? direcciones,
    bool? isLoading,
    String? error,
    String? search,
    String? ciudadSeleccionada,
    bool clearCiudad = false,
    String? provinciaSeleccionada,
    bool clearProvincia = false,
  }) {
    return DireccionState(
      direcciones: direcciones ?? this.direcciones,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      search: search ?? this.search,
      ciudadSeleccionada: clearCiudad ? null : (ciudadSeleccionada ?? this.ciudadSeleccionada),
      provinciaSeleccionada:
          clearProvincia ? null : (provinciaSeleccionada ?? this.provinciaSeleccionada),
    );
  }
}
