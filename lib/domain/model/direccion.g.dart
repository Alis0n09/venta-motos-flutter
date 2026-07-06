// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DireccionImpl _$$DireccionImplFromJson(Map<String, dynamic> json) =>
    _$DireccionImpl(
      id: (json['id'] as num).toInt(),
      cliente: (json['cliente'] as num).toInt(),
      calle: json['calle'] as String,
      ciudad: json['ciudad'] as String,
      provincia: json['provincia'] as String,
      principal: json['principal'] as bool? ?? false,
    );

Map<String, dynamic> _$$DireccionImplToJson(_$DireccionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cliente': instance.cliente,
      'calle': instance.calle,
      'ciudad': instance.ciudad,
      'provincia': instance.provincia,
      'principal': instance.principal,
    };
