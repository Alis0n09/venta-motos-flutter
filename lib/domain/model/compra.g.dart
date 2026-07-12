// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompraImpl _$$CompraImplFromJson(Map<String, dynamic> json) => _$CompraImpl(
      id: (json['id'] as num).toInt(),
      proveedor: (json['proveedor'] as num).toInt(),
      sucursalDestino: (json['sucursalDestino'] as num).toInt(),
      fecha: json['fecha'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$CompraImplToJson(_$CompraImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'proveedor': instance.proveedor,
      'sucursalDestino': instance.sucursalDestino,
      'fecha': instance.fecha,
      'total': instance.total,
    };
