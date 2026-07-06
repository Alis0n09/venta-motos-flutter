// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResenaImpl _$$ResenaImplFromJson(Map<String, dynamic> json) => _$ResenaImpl(
      id: (json['id'] as num).toInt(),
      moto: (json['moto'] as num).toInt(),
      motoNombre: json['motoNombre'] as String?,
      cliente: (json['cliente'] as num?)?.toInt(),
      clienteNombre: json['clienteNombre'] as String?,
      rating: (json['rating'] as num).toInt(),
      comentario: json['comentario'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
    );

Map<String, dynamic> _$$ResenaImplToJson(_$ResenaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moto': instance.moto,
      'motoNombre': instance.motoNombre,
      'cliente': instance.cliente,
      'clienteNombre': instance.clienteNombre,
      'rating': instance.rating,
      'comentario': instance.comentario,
      'fecha': instance.fecha.toIso8601String(),
    };
