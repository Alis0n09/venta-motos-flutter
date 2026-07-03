import 'package:freezed_annotation/freezed_annotation.dart';

part 'moto.freezed.dart';
part 'moto.g.dart';

@freezed
class Moto with _$Moto {
  const factory Moto({
    required int id,
    required int marca,
    required String marcaNombre,
    int? categoria,
    String? categoriaNombre,
    required String modelo,
    required int anio,
    required String color,
    required double precio,
    required int stock,
    required int cilindraje,
    required String estado,
    String? imagenUrl,
  }) = _Moto;

  factory Moto.fromJson(Map<String, dynamic> json) => Moto(
        id: json['id'] as int,
        marca: json['marca'] as int,
        marcaNombre: json['marca_nombre'] as String,
        categoria: json['categoria'] as int?,
        categoriaNombre: json['categoria_nombre'] as String?,
        modelo: json['modelo'] as String,
        anio: json['anio'] as int,
        color: json['color'] as String,
        precio: double.parse(json['precio'].toString()),
        stock: json['stock'] as int,
        cilindraje: json['cilindraje'] as int,
        estado: json['estado'] as String,
        imagenUrl: json['imagen_url'] as String?,
      );
}