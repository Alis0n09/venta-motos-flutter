// lib/domain/model/venta_admin.dart

import 'venta_detalle_item.dart';

class VentaAdmin {
  final int id;
  final int clienteId;
  final String clienteNombre;
  final int? vendedorId;
  final String? vendedorNombre;
  final DateTime fechaVenta;
  final String metodoPago;
  final double total;
  final List<VentaDetalleItem> detalles;

  const VentaAdmin({
    required this.id,
    required this.clienteId,
    required this.clienteNombre,
    this.vendedorId,
    this.vendedorNombre,
    required this.fechaVenta,
    required this.metodoPago,
    required this.total,
    required this.detalles,
  });

  factory VentaAdmin.fromJson(Map<String, dynamic> json) {
    return VentaAdmin(
      id: json['id'] as int,
      clienteId: json['cliente'] as int,
      clienteNombre: json['cliente_nombre']?.toString() ?? 'Cliente',
      vendedorId: json['vendedor'] as int?,
      vendedorNombre: json['vendedor_nombre']?.toString(),
      fechaVenta: DateTime.parse(json['fecha_venta'] as String),
      metodoPago: json['metodo_pago'] as String,
      total: double.parse(json['total'].toString()),
      detalles: (json['detalles'] as List? ?? [])
          .map((e) => VentaDetalleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
