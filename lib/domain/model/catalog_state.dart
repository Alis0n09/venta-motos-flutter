// lib/domain/model/catalog_state.dart

import 'moto.dart';

class CatalogState {
  final List<Moto> motos;
  final bool isLoading;
  final String? error;
  final int? marcaSeleccionada; // null = todas
  final String search;

  const CatalogState({
    this.motos = const [],
    this.isLoading = false,
    this.error,
    this.marcaSeleccionada,
    this.search = '',
  });

  CatalogState copyWith({
    List<Moto>? motos,
    bool? isLoading,
    String? error,
    int? marcaSeleccionada,
    bool clearMarca = false,
    String? search,
  }) {
    return CatalogState(
      motos: motos ?? this.motos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      marcaSeleccionada: clearMarca ? null : (marcaSeleccionada ?? this.marcaSeleccionada),
      search: search ?? this.search,
    );
  }
}