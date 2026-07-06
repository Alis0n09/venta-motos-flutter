import 'package:freezed_annotation/freezed_annotation.dart';

part 'detalle_compra.freezed.dart';
part 'detalle_compra.g.dart';

@freezed
class DetalleCompra with _$DetalleCompra {
  const factory DetalleCompra({
    required int id,
    required int compra,
    required int moto,
    required int cantidad,
    required double precioCosto,
  }) = _DetalleCompra;

  factory DetalleCompra.fromJson(Map<String, dynamic> json) => DetalleCompra(
        id: json['id'] as int,
        compra: json['compra'] as int,
        moto: json['moto'] as int,
        cantidad: json['cantidad'] as int,
        precioCosto: double.parse(json['precio_costo'].toString()),
      );
}
