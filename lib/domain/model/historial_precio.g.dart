// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historial_precio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistorialPrecioImpl _$$HistorialPrecioImplFromJson(
        Map<String, dynamic> json) =>
    _$HistorialPrecioImpl(
      id: (json['id'] as num).toInt(),
      moto: (json['moto'] as num).toInt(),
      motoNombre: json['motoNombre'] as String?,
      precioAnterior: (json['precioAnterior'] as num).toDouble(),
      precioNuevo: (json['precioNuevo'] as num).toDouble(),
      fecha: DateTime.parse(json['fecha'] as String),
      usuario: (json['usuario'] as num?)?.toInt(),
      usuarioNombre: json['usuarioNombre'] as String?,
    );

Map<String, dynamic> _$$HistorialPrecioImplToJson(
        _$HistorialPrecioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moto': instance.moto,
      'motoNombre': instance.motoNombre,
      'precioAnterior': instance.precioAnterior,
      'precioNuevo': instance.precioNuevo,
      'fecha': instance.fecha.toIso8601String(),
      'usuario': instance.usuario,
      'usuarioNombre': instance.usuarioNombre,
    };
