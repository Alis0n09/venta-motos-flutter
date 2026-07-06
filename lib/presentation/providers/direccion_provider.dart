// lib/presentation/providers/direccion_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/direccion_remote_datasource.dart';
import '../../domain/model/direccion_state.dart';

class DireccionNotifier extends StateNotifier<DireccionState> {
  final DireccionRemoteDatasource _datasource;

  DireccionNotifier(this._datasource) : super(const DireccionState()) {
    loadDirecciones();
  }

  Future<void> loadDirecciones() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final direcciones = await _datasource.getDirecciones(
        search: state.search,
        ciudad: state.ciudadSeleccionada,
        provincia: state.provinciaSeleccionada,
      );
      if (!mounted) return;
      state = state.copyWith(direcciones: direcciones, isLoading: false);
    } on ApiException catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar las direcciones.');
    }
  }

  void buscar(String texto) {
    state = state.copyWith(search: texto);
    loadDirecciones();
  }

  void filtrarPorCiudad(String? ciudad) {
    if (ciudad == null) {
      state = state.copyWith(clearCiudad: true);
    } else {
      state = state.copyWith(ciudadSeleccionada: ciudad);
    }
    loadDirecciones();
  }

  void filtrarPorProvincia(String? provincia) {
    if (provincia == null) {
      state = state.copyWith(clearProvincia: true);
    } else {
      state = state.copyWith(provinciaSeleccionada: provincia);
    }
    loadDirecciones();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(search: '', clearCiudad: true, clearProvincia: true);
    return loadDirecciones();
  }
}

final direccionProvider = StateNotifierProvider.autoDispose<DireccionNotifier, DireccionState>((ref) {
  return DireccionNotifier(ref.watch(direccionDatasourceProvider));
});
