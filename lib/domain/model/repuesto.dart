import 'package:freezed_annotation/freezed_annotation.dart';

part 'repuesto.freezed.dart';
part 'repuesto.g.dart';

@freezed
class Repuesto with _$Repuesto {
  const factory Repuesto({
    required int id,
    required String nombre,
    int? marcaCompatible,
    String? marcaCompatibleNombre,
    required int stock,
    required double precio,
  }) = _Repuesto;

  factory Repuesto.fromJson(Map<String, dynamic> json) => Repuesto(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        marcaCompatible: json['marca_compatible'] as int?,
        marcaCompatibleNombre: json['marca_compatible_nombre'] as String?,
        stock: json['stock'] as int,
        precio: double.parse(json['precio'].toString()),
      );
}