// lib/domain/model/logs_actividad_state.dart

import 'log_actividad.dart';

class LogsActividadState {
  final List<LogActividad> logs;
  final bool isLoading;
  final String? error;
  final String search;
  final String? accionSeleccionada; // null = todas
  final String? entidadSeleccionada; // null = todas
  final DateTime? fechaDesde;
  final DateTime? fechaHasta;

  const LogsActividadState({
    this.logs = const [],
    this.isLoading = false,
    this.error,
    this.search = '',
    this.accionSeleccionada,
    this.entidadSeleccionada,
    this.fechaDesde,
    this.fechaHasta,
  });

  LogsActividadState copyWith({
    List<LogActividad>? logs,
    bool? isLoading,
    String? error,
    String? search,
    String? accionSeleccionada,
    bool clearAccion = false,
    String? entidadSeleccionada,
    bool clearEntidad = false,
    DateTime? fechaDesde,
    bool clearFechaDesde = false,
    DateTime? fechaHasta,
    bool clearFechaHasta = false,
  }) {
    return LogsActividadState(
      logs: logs ?? this.logs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      search: search ?? this.search,
      accionSeleccionada: clearAccion ? null : (accionSeleccionada ?? this.accionSeleccionada),
      entidadSeleccionada: clearEntidad ? null : (entidadSeleccionada ?? this.entidadSeleccionada),
      fechaDesde: clearFechaDesde ? null : (fechaDesde ?? this.fechaDesde),
      fechaHasta: clearFechaHasta ? null : (fechaHasta ?? this.fechaHasta),
    );
  }
}
