// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificacion_cliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificacionClienteImpl _$$NotificacionClienteImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificacionClienteImpl(
      id: (json['id'] as num).toInt(),
      cliente: (json['cliente'] as num).toInt(),
      tipo: json['tipo'] as String,
      mensaje: json['mensaje'] as String,
      leido: json['leido'] as bool,
      fecha: DateTime.parse(json['fecha'] as String),
    );

Map<String, dynamic> _$$NotificacionClienteImplToJson(
        _$NotificacionClienteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cliente': instance.cliente,
      'tipo': instance.tipo,
      'mensaje': instance.mensaje,
      'leido': instance.leido,
      'fecha': instance.fecha.toIso8601String(),
    };
