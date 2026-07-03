// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventarioImpl _$$InventarioImplFromJson(Map<String, dynamic> json) =>
    _$InventarioImpl(
      id: (json['id'] as num).toInt(),
      motoNombre: json['motoNombre'] as String,
      sucursalNombre: json['sucursalNombre'] as String,
      cantidad: (json['cantidad'] as num).toInt(),
      ubicacionBodega: json['ubicacionBodega'] as String?,
    );

Map<String, dynamic> _$$InventarioImplToJson(_$InventarioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'motoNombre': instance.motoNombre,
      'sucursalNombre': instance.sucursalNombre,
      'cantidad': instance.cantidad,
      'ubicacionBodega': instance.ubicacionBodega,
    };
