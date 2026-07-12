// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_actividad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogActividadImpl _$$LogActividadImplFromJson(Map<String, dynamic> json) =>
    _$LogActividadImpl(
      id: (json['id'] as num).toInt(),
      usuario: (json['usuario'] as num?)?.toInt(),
      accion: json['accion'] as String,
      entidad: json['entidad'] as String,
      datosAntes: json['datosAntes'] as Map<String, dynamic>?,
      datosDespues: json['datosDespues'] as Map<String, dynamic>?,
      fecha: json['fecha'] as String,
    );

Map<String, dynamic> _$$LogActividadImplToJson(_$LogActividadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario,
      'accion': instance.accion,
      'entidad': instance.entidad,
      'datosAntes': instance.datosAntes,
      'datosDespues': instance.datosDespues,
      'fecha': instance.fecha,
    };
