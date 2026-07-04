// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventarioImpl _$$InventarioImplFromJson(Map<String, dynamic> json) =>
    _$InventarioImpl(
      id: (json['id'] as num).toInt(),
      moto: (json['moto'] as num).toInt(),
      motoNombre: json['motoNombre'] as String,
      sucursal: (json['sucursal'] as num).toInt(),
      sucursalNombre: json['sucursalNombre'] as String,
      cantidad: (json['cantidad'] as num).toInt(),
      ubicacionBodega: json['ubicacionBodega'] as String?,
    );

Map<String, dynamic> _$$InventarioImplToJson(_$InventarioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moto': instance.moto,
      'motoNombre': instance.motoNombre,
      'sucursal': instance.sucursal,
      'sucursalNombre': instance.sucursalNombre,
      'cantidad': instance.cantidad,
      'ubicacionBodega': instance.ubicacionBodega,
    };
