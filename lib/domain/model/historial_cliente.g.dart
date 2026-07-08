// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historial_cliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistorialClienteImpl _$$HistorialClienteImplFromJson(
        Map<String, dynamic> json) =>
    _$HistorialClienteImpl(
      id: (json['id'] as num).toInt(),
      cliente: (json['cliente'] as num).toInt(),
      clienteNombre: json['clienteNombre'] as String?,
      clienteCedula: json['clienteCedula'] as String?,
      tipoEvento: json['tipoEvento'] as String,
      detalle:
          json['detalle'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      fecha: DateTime.parse(json['fecha'] as String),
    );

Map<String, dynamic> _$$HistorialClienteImplToJson(
        _$HistorialClienteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cliente': instance.cliente,
      'clienteNombre': instance.clienteNombre,
      'clienteCedula': instance.clienteCedula,
      'tipoEvento': instance.tipoEvento,
      'detalle': instance.detalle,
      'fecha': instance.fecha.toIso8601String(),
    };
