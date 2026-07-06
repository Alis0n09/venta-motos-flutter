// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuota_pago.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CuotaPagoImpl _$$CuotaPagoImplFromJson(Map<String, dynamic> json) =>
    _$CuotaPagoImpl(
      id: (json['id'] as num).toInt(),
      financiamiento: (json['financiamiento'] as num).toInt(),
      numeroCuota: (json['numeroCuota'] as num).toInt(),
      fechaVencimiento: DateTime.parse(json['fechaVencimiento'] as String),
      fechaPago: json['fechaPago'] == null
          ? null
          : DateTime.parse(json['fechaPago'] as String),
      monto: (json['monto'] as num).toDouble(),
      estado: json['estado'] as String,
    );

Map<String, dynamic> _$$CuotaPagoImplToJson(_$CuotaPagoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'financiamiento': instance.financiamiento,
      'numeroCuota': instance.numeroCuota,
      'fechaVencimiento': instance.fechaVencimiento.toIso8601String(),
      'fechaPago': instance.fechaPago?.toIso8601String(),
      'monto': instance.monto,
      'estado': instance.estado,
    };
