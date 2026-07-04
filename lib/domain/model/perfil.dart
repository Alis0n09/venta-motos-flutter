import 'package:freezed_annotation/freezed_annotation.dart';

part 'perfil.freezed.dart';
part 'perfil.g.dart';

@freezed
class PerfilCuenta with _$PerfilCuenta {
  const factory PerfilCuenta({
    required String username,
    required String email,
    String? firstName,
    String? lastName,
  }) = _PerfilCuenta;

  factory PerfilCuenta.fromJson(Map<String, dynamic> json) => PerfilCuenta(
        username: json['username'] as String,
        email: json['email'] as String,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
      );
}

@freezed
class PerfilCliente with _$PerfilCliente {
  const factory PerfilCliente({
    required String nombre,
    required String apellido,
    required String cedula,
    String? telefono,
    String? direccion,
  }) = _PerfilCliente;

  factory PerfilCliente.fromJson(Map<String, dynamic> json) => PerfilCliente(
        nombre: json['nombre'] as String,
        apellido: json['apellido'] as String,
        cedula: json['cedula'] as String,
        telefono: json['telefono'] as String?,
        direccion: json['direccion'] as String?,
      );
}