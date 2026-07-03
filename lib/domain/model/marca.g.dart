// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marca.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarcaImpl _$$MarcaImplFromJson(Map<String, dynamic> json) => _$MarcaImpl(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      paisOrigen: json['paisOrigen'] as String?,
      activa: json['activa'] as bool? ?? true,
    );

Map<String, dynamic> _$$MarcaImplToJson(_$MarcaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'paisOrigen': instance.paisOrigen,
      'activa': instance.activa,
    };
