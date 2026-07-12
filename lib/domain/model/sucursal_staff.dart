import 'package:freezed_annotation/freezed_annotation.dart';

part 'sucursal_staff.freezed.dart';
part 'sucursal_staff.g.dart';

@freezed
class SucursalStaff with _$SucursalStaff {
  const factory SucursalStaff({
    required int id,
    required int staff,
    required String staffNombre,
    required int sucursal,
    required String sucursalNombre,
    required String fechaAsignacion,
  }) = _SucursalStaff;

  factory SucursalStaff.fromJson(Map<String, dynamic> json) => SucursalStaff(
        id: json['id'] as int,
        staff: json['staff'] as int,
        staffNombre: json['staff_nombre'] as String,
        sucursal: json['sucursal'] as int,
        sucursalNombre: json['sucursal_nombre'] as String,
        fechaAsignacion: json['fecha_asignacion'] as String,
      );
}
