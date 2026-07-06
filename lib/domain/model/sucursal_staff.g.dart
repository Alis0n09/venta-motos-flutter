// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sucursal_staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SucursalStaffImpl _$$SucursalStaffImplFromJson(Map<String, dynamic> json) =>
    _$SucursalStaffImpl(
      id: (json['id'] as num).toInt(),
      staff: (json['staff'] as num).toInt(),
      staffNombre: json['staffNombre'] as String,
      sucursal: (json['sucursal'] as num).toInt(),
      sucursalNombre: json['sucursalNombre'] as String,
      fechaAsignacion: json['fechaAsignacion'] as String,
    );

Map<String, dynamic> _$$SucursalStaffImplToJson(_$SucursalStaffImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'staff': instance.staff,
      'staffNombre': instance.staffNombre,
      'sucursal': instance.sucursal,
      'sucursalNombre': instance.sucursalNombre,
      'fechaAsignacion': instance.fechaAsignacion,
    };
