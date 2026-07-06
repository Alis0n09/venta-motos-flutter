import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_actividad.freezed.dart';
part 'log_actividad.g.dart';

@freezed
class LogActividad with _$LogActividad {
  const factory LogActividad({
    required int id,
    int? usuario,
    required String accion,
    required String entidad,
    Map<String, dynamic>? datosAntes,
    Map<String, dynamic>? datosDespues,
    required String fecha,
  }) = _LogActividad;

  factory LogActividad.fromJson(Map<String, dynamic> json) => LogActividad(
        id: json['id'] as int,
        usuario: json['usuario'] as int?,
        accion: json['accion'] as String,
        entidad: json['entidad'] as String,
        datosAntes: json['datos_antes'] as Map<String, dynamic>?,
        datosDespues: json['datos_despues'] as Map<String, dynamic>?,
        fecha: json['fecha'] as String,
      );
}
