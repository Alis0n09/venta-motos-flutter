import 'package:freezed_annotation/freezed_annotation.dart';

part 'compra.freezed.dart';
part 'compra.g.dart';

@freezed
class Compra with _$Compra {
  const factory Compra({
    required int id,
    required int proveedor,
    required int sucursalDestino,
    required String fecha,
    required double total,
  }) = _Compra;

  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        id: json['id'] as int,
        proveedor: json['proveedor'] as int,
        sucursalDestino: json['sucursal_destino'] as int,
        fecha: json['fecha'] as String,
        total: double.parse(json['total'].toString()),
      );
}
