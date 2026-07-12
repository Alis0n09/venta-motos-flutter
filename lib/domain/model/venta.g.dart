// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VentaImpl _$$VentaImplFromJson(Map<String, dynamic> json) => _$VentaImpl(
      id: (json['id'] as num).toInt(),
      clienteNombre: json['clienteNombre'] as String?,
      vendedorNombre: json['vendedorNombre'] as String?,
      fechaVenta: DateTime.parse(json['fechaVenta'] as String),
      metodoPago: json['metodoPago'] as String,
      total: (json['total'] as num).toDouble(),
      unidadesVendidas: (json['unidadesVendidas'] as num).toInt(),
    );

Map<String, dynamic> _$$VentaImplToJson(_$VentaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clienteNombre': instance.clienteNombre,
      'vendedorNombre': instance.vendedorNombre,
      'fechaVenta': instance.fechaVenta.toIso8601String(),
      'metodoPago': instance.metodoPago,
      'total': instance.total,
      'unidadesVendidas': instance.unidadesVendidas,
    };
