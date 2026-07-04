// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sucursal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SucursalImpl _$$SucursalImplFromJson(Map<String, dynamic> json) =>
    _$SucursalImpl(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      direccion: json['direccion'] as String,
      ciudad: json['ciudad'] as String,
      telefono: json['telefono'] as String?,
    );

Map<String, dynamic> _$$SucursalImplToJson(_$SucursalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'direccion': instance.direccion,
      'ciudad': instance.ciudad,
      'telefono': instance.telefono,
    };
