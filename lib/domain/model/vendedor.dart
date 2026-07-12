import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendedor.freezed.dart';
part 'vendedor.g.dart';

@freezed
class Vendedor with _$Vendedor {
  const factory Vendedor({
    required int id,
    required String nombre,
    required String apellido,
    String? rol,
  }) = _Vendedor;

  factory Vendedor.fromJson(Map<String, dynamic> json) => Vendedor(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        apellido: json['apellido'] as String,
        rol: json['rol'] as String?,
      );
}
