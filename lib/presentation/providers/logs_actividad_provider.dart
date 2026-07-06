// lib/presentation/providers/logs_actividad_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/logs_actividad_remote_datasource.dart';
import '../../domain/model/logs_actividad_state.dart';

String _formatearFechaParaApi(DateTime fecha) {
  String dos(int n) => n.toString().padLeft(2, '0');
  return '${fecha.year}-${dos(fecha.month)}-${dos(fecha.day)}';
}

class LogsActividadNotifier extends StateNotifier<LogsActividadState> {
  final LogsActividadRemoteDatasource _datasource;

  LogsActividadNotifier(this._datasource) : super(const LogsActividadState()) {
    loadLogs();
  }

  Future<void> loadLogs() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final logs = await _datasource.getLogs(
        accion: state.accionSeleccionada,
        entidad: state.entidadSeleccionada,
        fechaDesde: state.fechaDesde == null ? null : _formatearFechaParaApi(state.fechaDesde!),
        fechaHasta: state.fechaHasta == null ? null : _formatearFechaParaApi(state.fechaHasta!),
        search: state.search,
        ordering: '-fecha',
      );
      state = state.copyWith(logs: logs, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Error inesperado al cargar los logs.');
    }
  }

  void buscar(String texto) {
    state = state.copyWith(search: texto);
    loadLogs();
  }

  void filtrarPorAccion(String? accion) {
    if (accion == null) {
      state = state.copyWith(clearAccion: true);
    } else {
      state = state.copyWith(accionSeleccionada: accion);
    }
    loadLogs();
  }

  void filtrarPorEntidad(String? entidad) {
    if (entidad == null) {
      state = state.copyWith(clearEntidad: true);
    } else {
      state = state.copyWith(entidadSeleccionada: entidad);
    }
    loadLogs();
  }

  void filtrarPorRangoFechas(DateTime? desde, DateTime? hasta) {
    state = state.copyWith(
      fechaDesde: desde,
      clearFechaDesde: desde == null,
      fechaHasta: hasta,
      clearFechaHasta: hasta == null,
    );
    loadLogs();
  }

  Future<void> resetFiltros() {
    state = state.copyWith(
      search: '',
      clearAccion: true,
      clearEntidad: true,
      clearFechaDesde: true,
      clearFechaHasta: true,
    );
    return loadLogs();
  }
}

final logsActividadProvider =
    StateNotifierProvider.autoDispose<LogsActividadNotifier, LogsActividadState>((ref) {
  return LogsActividadNotifier(ref.watch(logsActividadDatasourceProvider));
});
