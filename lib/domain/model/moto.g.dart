// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MotoImpl _$$MotoImplFromJson(Map<String, dynamic> json) => _$MotoImpl(
      id: (json['id'] as num).toInt(),
      marca: (json['marca'] as num).toInt(),
      marcaNombre: json['marcaNombre'] as String,
      categoria: (json['categoria'] as num?)?.toInt(),
      categoriaNombre: json['categoriaNombre'] as String?,
      modelo: json['modelo'] as String,
      anio: (json['anio'] as num).toInt(),
      color: json['color'] as String,
      precio: (json['precio'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      cilindraje: (json['cilindraje'] as num).toInt(),
      estado: json['estado'] as String,
      imagenUrl: json['imagenUrl'] as String?,
    );

Map<String, dynamic> _$$MotoImplToJson(_$MotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'marca': instance.marca,
      'marcaNombre': instance.marcaNombre,
      'categoria': instance.categoria,
      'categoriaNombre': instance.categoriaNombre,
      'modelo': instance.modelo,
      'anio': instance.anio,
      'color': instance.color,
      'precio': instance.precio,
      'stock': instance.stock,
      'cilindraje': instance.cilindraje,
      'estado': instance.estado,
      'imagenUrl': instance.imagenUrl,
    };
