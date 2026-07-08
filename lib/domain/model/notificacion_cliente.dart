import 'package:freezed_annotation/freezed_annotation.dart';

part 'notificacion_cliente.freezed.dart';
part 'notificacion_cliente.g.dart';

@freezed
class NotificacionCliente with _$NotificacionCliente {
  const factory NotificacionCliente({
    required int id,
    required int cliente,
    required String tipo,
    required String mensaje,
    required bool leido,
    required DateTime fecha,
  }) = _NotificacionCliente;

  factory NotificacionCliente.fromJson(Map<String, dynamic> json) => NotificacionCliente(
        id: json['id'] as int,
        cliente: json['cliente'] as int,
        tipo: json['tipo'] as String,
        mensaje: json['mensaje'] as String,
        leido: json['leido'] as bool,
        fecha: DateTime.parse(json['fecha'] as String),
      );
}