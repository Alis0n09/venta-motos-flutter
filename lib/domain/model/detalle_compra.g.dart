// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalle_compra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetalleCompraImpl _$$DetalleCompraImplFromJson(Map<String, dynamic> json) =>
    _$DetalleCompraImpl(
      id: (json['id'] as num).toInt(),
      compra: (json['compra'] as num).toInt(),
      moto: (json['moto'] as num).toInt(),
      cantidad: (json['cantidad'] as num).toInt(),
      precioCosto: (json['precioCosto'] as num).toDouble(),
    );

Map<String, dynamic> _$$DetalleCompraImplToJson(_$DetalleCompraImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'compra': instance.compra,
      'moto': instance.moto,
      'cantidad': instance.cantidad,
      'precioCosto': instance.precioCosto,
    };
