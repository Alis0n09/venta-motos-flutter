// lib/domain/model/carrito_item.dart

class CarritoItem {
  final int motoId;
  final String marcaNombre;
  final String modelo;
  final double precioUnitario;
  final int stockDisponible;
  final int cantidad;

  const CarritoItem({
    required this.motoId,
    required this.marcaNombre,
    required this.modelo,
    required this.precioUnitario,
    required this.stockDisponible,
    this.cantidad = 1,
  });

  double get subtotal => precioUnitario * cantidad;

  CarritoItem copyWith({int? cantidad}) => CarritoItem(
        motoId: motoId,
        marcaNombre: marcaNombre,
        modelo: modelo,
        precioUnitario: precioUnitario,
        stockDisponible: stockDisponible,
        cantidad: cantidad ?? this.cantidad,
      );
}
