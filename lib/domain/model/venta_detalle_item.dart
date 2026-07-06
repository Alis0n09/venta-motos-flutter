// lib/domain/model/venta_detalle_item.dart

class VentaDetalleItem {
  final int motoId;
  final String motoNombre;
  final int cantidad;
  final double precioUnitario;

  const VentaDetalleItem({
    required this.motoId,
    required this.motoNombre,
    required this.cantidad,
    required this.precioUnitario,
  });

  double get subtotal => precioUnitario * cantidad;

  factory VentaDetalleItem.fromJson(Map<String, dynamic> json) {
    return VentaDetalleItem(
      motoId: json['moto'] as int,
      motoNombre: json['moto_nombre']?.toString() ?? 'Moto #${json['moto']}',
      cantidad: json['cantidad'] as int,
      precioUnitario: double.parse(json['precio_unitario'].toString()),
    );
  }
}
