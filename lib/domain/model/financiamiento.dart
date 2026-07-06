import 'package:freezed_annotation/freezed_annotation.dart';

part 'financiamiento.freezed.dart';
part 'financiamiento.g.dart';

@freezed
class Financiamiento with _$Financiamiento {
  const factory Financiamiento({
    required int id,
    required int venta,
    String? clienteNombre,
    String? clienteCedula,
    @Default(<String>[]) List<String> motoDetalle,
    required double montoFinanciado,
    required double tasaInteres,
    required int plazoMeses,
    required DateTime fechaInicio,
    DateTime? fechaFin,
    required String estado,
    double? cuotaMensual,
  }) = _Financiamiento;

  factory Financiamiento.fromJson(Map<String, dynamic> json) => Financiamiento(
        id: json['id'] as int,
        venta: json['venta'] as int,
        clienteNombre: json['cliente_nombre'] as String?,
        clienteCedula: json['cliente_cedula'] as String?,
        motoDetalle: (json['moto_detalle'] as List? ?? [])
            .map((e) => e.toString())
            .toList(),
        montoFinanciado: double.parse(json['monto_financiado'].toString()),
        tasaInteres: double.parse(json['tasa_interes'].toString()),
        plazoMeses: json['plazo_meses'] as int,
        fechaInicio: DateTime.parse(json['fecha_inicio'] as String),
        fechaFin: json['fecha_fin'] != null ? DateTime.parse(json['fecha_fin'] as String) : null,
        estado: json['estado'] as String,
        cuotaMensual: json['cuota_mensual'] != null
            ? double.parse(json['cuota_mensual'].toString())
            : null,
      );
}