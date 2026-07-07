class ClienteMini {
  final int id;
  final String nombre;
  final String apellido;

  const ClienteMini({required this.id, required this.nombre, required this.apellido});

  factory ClienteMini.fromJson(Map<String, dynamic> json) => ClienteMini(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        apellido: json['apellido'] as String,
      );

  String get nombreCompleto => '$nombre $apellido';
}