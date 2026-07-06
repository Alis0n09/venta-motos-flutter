import 'package:freezed_annotation/freezed_annotation.dart';

part 'historial_precio.freezed.dart';
part 'historial_precio.g.dart';

@freezed
class HistorialPrecio with _$HistorialPrecio {
  const factory HistorialPrecio({
    required int id,
    required int moto,
    String? motoNombre,
    required double precioAnterior,
    required double precioNuevo,
    required DateTime fecha,
    int? usuario,
    String? usuarioNombre,
  }) = _HistorialPrecio;

  factory HistorialPrecio.fromJson(Map<String, dynamic> json) => HistorialPrecio(
        id: json['id'] as int,
        moto: json['moto'] as int,
        motoNombre: json['moto_nombre'] as String?,
        precioAnterior: double.parse(json['precio_anterior'].toString()),
        precioNuevo: double.parse(json['precio_nuevo'].toString()),
        fecha: DateTime.parse(json['fecha'] as String),
        usuario: json['usuario'] as int?,
        usuarioNombre: json['usuario_nombre'] as String?,
      );
}