// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mantenimiento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MantenimientoImpl _$$MantenimientoImplFromJson(Map<String, dynamic> json) =>
    _$MantenimientoImpl(
      id: (json['id'] as num).toInt(),
      moto: (json['moto'] as num).toInt(),
      motoDetalle: json['motoDetalle'] as String?,
      cliente: (json['cliente'] as num?)?.toInt(),
      clienteNombre: json['clienteNombre'] as String?,
      clienteCedula: json['clienteCedula'] as String?,
      fecha: DateTime.parse(json['fecha'] as String),
      tipo: json['tipo'] as String,
      costo: (json['costo'] as num).toDouble(),
    );

Map<String, dynamic> _$$MantenimientoImplToJson(_$MantenimientoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moto': instance.moto,
      'motoDetalle': instance.motoDetalle,
      'cliente': instance.cliente,
      'clienteNombre': instance.clienteNombre,
      'clienteCedula': instance.clienteCedula,
      'fecha': instance.fecha.toIso8601String(),
      'tipo': instance.tipo,
      'costo': instance.costo,
    };
