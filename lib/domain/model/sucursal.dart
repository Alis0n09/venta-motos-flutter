import 'package:freezed_annotation/freezed_annotation.dart';

part 'sucursal.freezed.dart';
part 'sucursal.g.dart';

@freezed
class Sucursal with _$Sucursal {
  const factory Sucursal({
    required int id,
    required String nombre,
    required String direccion,
    required String ciudad,
    String? telefono,
  }) = _Sucursal;

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        direccion: json['direccion'] as String,
        ciudad: json['ciudad'] as String,
        telefono: json['telefono'] as String?,
      );
}
