import 'package:freezed_annotation/freezed_annotation.dart';

part 'garantia.freezed.dart';
part 'garantia.g.dart';

@freezed
class Garantia with _$Garantia {
  const factory Garantia({
    required int id,
    required int venta,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    required String tipo,
  }) = _Garantia;

  factory Garantia.fromJson(Map<String, dynamic> json) => Garantia(
        id: json['id'] as int,
        venta: json['venta'] as int,
        fechaInicio: DateTime.parse(json['fecha_inicio'] as String),
        fechaFin: DateTime.parse(json['fecha_fin'] as String),
        tipo: json['tipo'] as String,
      );
}