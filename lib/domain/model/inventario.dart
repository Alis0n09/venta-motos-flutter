import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventario.freezed.dart';
part 'inventario.g.dart';

@freezed
class Inventario with _$Inventario {
  const factory Inventario({
    required int id,
    required int moto,
    required String motoNombre,
    required int sucursal,
    required String sucursalNombre,
    required int cantidad,
    String? ubicacionBodega,
  }) = _Inventario;

  factory Inventario.fromJson(Map<String, dynamic> json) => Inventario(
        id: json['id'] as int,
        moto: json['moto'] as int,
        motoNombre: json['moto_nombre'] as String,
        sucursal: json['sucursal'] as int,
        sucursalNombre: json['sucursal_nombre'] as String,
        cantidad: json['cantidad'] as int,
        ubicacionBodega: json['ubicacion_bodega'] as String?,
      );
}