// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financiamiento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinanciamientoImpl _$$FinanciamientoImplFromJson(Map<String, dynamic> json) =>
    _$FinanciamientoImpl(
      id: (json['id'] as num).toInt(),
      venta: (json['venta'] as num).toInt(),
      clienteNombre: json['clienteNombre'] as String?,
      clienteCedula: json['clienteCedula'] as String?,
      motoDetalle: (json['motoDetalle'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      montoFinanciado: (json['montoFinanciado'] as num).toDouble(),
      tasaInteres: (json['tasaInteres'] as num).toDouble(),
      plazoMeses: (json['plazoMeses'] as num).toInt(),
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      fechaFin: json['fechaFin'] == null
          ? null
          : DateTime.parse(json['fechaFin'] as String),
      estado: json['estado'] as String,
      cuotaMensual: (json['cuotaMensual'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$FinanciamientoImplToJson(
        _$FinanciamientoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'venta': instance.venta,
      'clienteNombre': instance.clienteNombre,
      'clienteCedula': instance.clienteCedula,
      'motoDetalle': instance.motoDetalle,
      'montoFinanciado': instance.montoFinanciado,
      'tasaInteres': instance.tasaInteres,
      'plazoMeses': instance.plazoMeses,
      'fechaInicio': instance.fechaInicio.toIso8601String(),
      'fechaFin': instance.fechaFin?.toIso8601String(),
      'estado': instance.estado,
      'cuotaMensual': instance.cuotaMensual,
    };
