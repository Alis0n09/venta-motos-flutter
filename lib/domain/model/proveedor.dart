import 'package:freezed_annotation/freezed_annotation.dart';

part 'proveedor.freezed.dart';
part 'proveedor.g.dart';

@freezed
class Proveedor with _$Proveedor {
  const factory Proveedor({
    required int id,
    required String empresa,
    String? contacto,
    String? correo,
    String? pais,
  }) = _Proveedor;

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        id: json['id'] as int,
        empresa: json['empresa'] as String,
        contacto: json['contacto'] as String?,
        correo: json['correo'] as String?,
        pais: json['pais'] as String?,
      );
}
