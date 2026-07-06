// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proveedor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProveedorImpl _$$ProveedorImplFromJson(Map<String, dynamic> json) =>
    _$ProveedorImpl(
      id: (json['id'] as num).toInt(),
      empresa: json['empresa'] as String,
      contacto: json['contacto'] as String?,
      correo: json['correo'] as String?,
      pais: json['pais'] as String?,
    );

Map<String, dynamic> _$$ProveedorImplToJson(_$ProveedorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empresa': instance.empresa,
      'contacto': instance.contacto,
      'correo': instance.correo,
      'pais': instance.pais,
    };
