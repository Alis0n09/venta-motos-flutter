// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerfilCuentaImpl _$$PerfilCuentaImplFromJson(Map<String, dynamic> json) =>
    _$PerfilCuentaImpl(
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$$PerfilCuentaImplToJson(_$PerfilCuentaImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

_$PerfilClienteImpl _$$PerfilClienteImplFromJson(Map<String, dynamic> json) =>
    _$PerfilClienteImpl(
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      cedula: json['cedula'] as String,
      telefono: json['telefono'] as String?,
      direccion: json['direccion'] as String?,
    );

Map<String, dynamic> _$$PerfilClienteImplToJson(_$PerfilClienteImpl instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'cedula': instance.cedula,
      'telefono': instance.telefono,
      'direccion': instance.direccion,
    };
