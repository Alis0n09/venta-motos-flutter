import 'package:freezed_annotation/freezed_annotation.dart';

part 'historial_cliente.freezed.dart';
part 'historial_cliente.g.dart';

@freezed
class HistorialCliente with _$HistorialCliente {
  const factory HistorialCliente({
    required int id,
    required int cliente,
    String? clienteNombre,
    String? clienteCedula,
    required String tipoEvento,
    @Default(<String, dynamic>{}) Map<String, dynamic> detalle,
    required DateTime fecha,
  }) = _HistorialCliente;

  factory HistorialCliente.fromJson(Map<String, dynamic> json) => HistorialCliente(
        id: json['id'] as int,
        cliente: json['cliente'] as int,
        clienteNombre: json['cliente_nombre'] as String?,
        clienteCedula: json['cliente_cedula'] as String?,
        tipoEvento: json['tipo_evento'] as String,
        detalle: Map<String, dynamic>.from(json['detalle'] as Map? ?? {}),
        fecha: DateTime.parse(json['fecha'] as String),
      );
}