// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendedor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VendedorImpl _$$VendedorImplFromJson(Map<String, dynamic> json) =>
    _$VendedorImpl(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      rol: json['rol'] as String?,
    );

Map<String, dynamic> _$$VendedorImplToJson(_$VendedorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'rol': instance.rol,
    };
