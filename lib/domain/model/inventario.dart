import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventario.freezed.dart';
part 'inventario.g.dart';

@freezed
class Inventario with _$Inventario {
  const factory Inventario({
    required int id,
    required String motoNombre,
    required String sucursalNombre,
    required int cantidad,
    String? ubicacionBodega,
  }) = _Inventario;

  factory Inventario.fromJson(Map<String, dynamic> json) => Inventario(
        id: json['id'] as int,
        motoNombre: json['moto_nombre'] as String,
        sucursalNombre: json['sucursal_nombre'] as String,
        cantidad: json['cantidad'] as int,
        ubicacionBodega: json['ubicacion_bodega'] as String?,
      );
}