import 'package:freezed_annotation/freezed_annotation.dart';

part 'categoria.freezed.dart';
part 'categoria.g.dart';

@freezed
class Categoria with _$Categoria {
  const factory Categoria({
    required int id,
    required String nombre,
    String? descripcion,
  }) = _Categoria;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        descripcion: json['descripcion'] as String?,
      );
}