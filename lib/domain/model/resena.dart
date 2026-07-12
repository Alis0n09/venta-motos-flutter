import 'package:freezed_annotation/freezed_annotation.dart';

part 'resena.freezed.dart';
part 'resena.g.dart';

@freezed
class Resena with _$Resena {
  const factory Resena({
    required int id,
    required int moto,
    String? motoNombre,
    int? cliente,
    String? clienteNombre,
    required int rating,
    required String comentario,
    required DateTime fecha,
  }) = _Resena;

  factory Resena.fromJson(Map<String, dynamic> json) => Resena(
        id: json['id'] as int,
        moto: json['moto'] as int,
        motoNombre: json['moto_nombre'] as String?,
        cliente: json['cliente'] as int?,
        clienteNombre: json['cliente_nombre'] as String?,
        rating: json['rating'] as int,
        comentario: json['comentario'] as String? ?? '',
        fecha: DateTime.parse(json['fecha'] as String),
      );
}