import 'package:freezed_annotation/freezed_annotation.dart';

part 'cuota_pago.freezed.dart';
part 'cuota_pago.g.dart';

@freezed
class CuotaPago with _$CuotaPago {
  const factory CuotaPago({
    required int id,
    required int financiamiento,
    required int numeroCuota,
    required DateTime fechaVencimiento,
    DateTime? fechaPago,
    required double monto,
    required String estado,
  }) = _CuotaPago;

  factory CuotaPago.fromJson(Map<String, dynamic> json) => CuotaPago(
        id: json['id'] as int,
        financiamiento: json['financiamiento'] as int,
        numeroCuota: json['numero_cuota'] as int,
        fechaVencimiento: DateTime.parse(json['fecha_vencimiento'] as String),
        fechaPago: json['fecha_pago'] != null ? DateTime.parse(json['fecha_pago'] as String) : null,
        monto: double.parse(json['monto'].toString()),
        estado: json['estado'] as String,
      );
}