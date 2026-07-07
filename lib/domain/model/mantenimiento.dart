import 'package:freezed_annotation/freezed_annotation.dart';

part 'mantenimiento.freezed.dart';
part 'mantenimiento.g.dart';

@freezed
class Mantenimiento with _$Mantenimiento {
  const factory Mantenimiento({
    required int id,
    required int moto,
    String? motoDetalle,
    int? cliente,
    String? clienteNombre,
    String? clienteCedula,
    required DateTime fecha,
    required String tipo,
    required double costo,
  }) = _Mantenimiento;

  factory Mantenimiento.fromJson(Map<String, dynamic> json) => Mantenimiento(
        id: json['id'] as int,
        moto: json['moto'] as int,
        motoDetalle: json['moto_detalle'] as String?,
        cliente: json['cliente'] as int?,
        clienteNombre: json['cliente_nombre'] as String?,
        clienteCedula: json['cliente_cedula'] as String?,
        fecha: DateTime.parse(json['fecha'] as String),
        tipo: json['tipo'] as String,
        costo: double.parse(json['costo'].toString()),
      );
}