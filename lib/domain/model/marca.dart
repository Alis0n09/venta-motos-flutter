import 'package:freezed_annotation/freezed_annotation.dart';

part 'marca.freezed.dart';
part 'marca.g.dart';

@freezed
class Marca with _$Marca {
  const factory Marca({
    required int id,
    required String nombre,
    String? paisOrigen,
    @Default(true) bool activa,
  }) = _Marca;

  factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        paisOrigen: json['pais_origen'] as String?,
        activa: json['activa'] as bool? ?? true,
      );
}