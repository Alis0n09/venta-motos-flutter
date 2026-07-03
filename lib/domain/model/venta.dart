import 'package:freezed_annotation/freezed_annotation.dart';

part 'venta.freezed.dart';
part 'venta.g.dart';

int _sumarUnidades(List? detalles) {
  if (detalles == null) return 0;
  return detalles.fold<int>(0, (sum, d) => sum + (d['cantidad'] as int));
}

@freezed
class Venta with _$Venta {
  const factory Venta({
    required int id,
    String? clienteNombre,
    String? vendedorNombre,
    required DateTime fechaVenta,
    required String metodoPago,
    required double total,
    required int unidadesVendidas,
  }) = _Venta;

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
        id: json['id'] as int,
        clienteNombre: json['cliente_nombre'] as String?,
        vendedorNombre: json['vendedor_nombre'] as String?,
        fechaVenta: DateTime.parse(json['fecha_venta'] as String),
        metodoPago: json['metodo_pago'] as String,
        total: double.parse(json['total'].toString()),
        unidadesVendidas: _sumarUnidades(json['detalles'] as List?),
      );
}