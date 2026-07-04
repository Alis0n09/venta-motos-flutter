// lib/domain/model/vendedor_simple.dart

class VendedorSimple {
  final int id;
  final String nombreCompleto;
  final String rol;

  const VendedorSimple({
    required this.id,
    required this.nombreCompleto,
    required this.rol,
  });

  factory VendedorSimple.fromJson(Map<String, dynamic> json) {
    final nombre = json['nombre']?.toString() ?? '';
    final apellido = json['apellido']?.toString() ?? '';
    return VendedorSimple(
      id: json['id'] as int,
      nombreCompleto: '$nombre $apellido'.trim(),
      rol: json['rol']?.toString() ?? '',
    );
  }
}
