// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garantia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GarantiaImpl _$$GarantiaImplFromJson(Map<String, dynamic> json) =>
    _$GarantiaImpl(
      id: (json['id'] as num).toInt(),
      venta: (json['venta'] as num).toInt(),
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      fechaFin: DateTime.parse(json['fechaFin'] as String),
      tipo: json['tipo'] as String,
    );

Map<String, dynamic> _$$GarantiaImplToJson(_$GarantiaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'venta': instance.venta,
      'fechaInicio': instance.fechaInicio.toIso8601String(),
      'fechaFin': instance.fechaFin.toIso8601String(),
      'tipo': instance.tipo,
    };
