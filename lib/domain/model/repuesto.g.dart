// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repuesto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepuestoImpl _$$RepuestoImplFromJson(Map<String, dynamic> json) =>
    _$RepuestoImpl(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      marcaCompatible: (json['marcaCompatible'] as num?)?.toInt(),
      marcaCompatibleNombre: json['marcaCompatibleNombre'] as String?,
      stock: (json['stock'] as num).toInt(),
      precio: (json['precio'] as num).toDouble(),
    );

Map<String, dynamic> _$$RepuestoImplToJson(_$RepuestoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'marcaCompatible': instance.marcaCompatible,
      'marcaCompatibleNombre': instance.marcaCompatibleNombre,
      'stock': instance.stock,
      'precio': instance.precio,
    };
