// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sucursal_staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SucursalStaff _$SucursalStaffFromJson(Map<String, dynamic> json) {
  return _SucursalStaff.fromJson(json);
}

/// @nodoc
mixin _$SucursalStaff {
  int get id => throw _privateConstructorUsedError;
  int get staff => throw _privateConstructorUsedError;
  String get staffNombre => throw _privateConstructorUsedError;
  int get sucursal => throw _privateConstructorUsedError;
  String get sucursalNombre => throw _privateConstructorUsedError;
  String get fechaAsignacion => throw _privateConstructorUsedError;

  /// Serializes this SucursalStaff to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SucursalStaff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SucursalStaffCopyWith<SucursalStaff> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SucursalStaffCopyWith<$Res> {
  factory $SucursalStaffCopyWith(
          SucursalStaff value, $Res Function(SucursalStaff) then) =
      _$SucursalStaffCopyWithImpl<$Res, SucursalStaff>;
  @useResult
  $Res call(
      {int id,
      int staff,
      String staffNombre,
      int sucursal,
      String sucursalNombre,
      String fechaAsignacion});
}

/// @nodoc
class _$SucursalStaffCopyWithImpl<$Res, $Val extends SucursalStaff>
    implements $SucursalStaffCopyWith<$Res> {
  _$SucursalStaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SucursalStaff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? staff = null,
    Object? staffNombre = null,
    Object? sucursal = null,
    Object? sucursalNombre = null,
    Object? fechaAsignacion = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      staff: null == staff
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as int,
      staffNombre: null == staffNombre
          ? _value.staffNombre
          : staffNombre // ignore: cast_nullable_to_non_nullable
              as String,
      sucursal: null == sucursal
          ? _value.sucursal
          : sucursal // ignore: cast_nullable_to_non_nullable
              as int,
      sucursalNombre: null == sucursalNombre
          ? _value.sucursalNombre
          : sucursalNombre // ignore: cast_nullable_to_non_nullable
              as String,
      fechaAsignacion: null == fechaAsignacion
          ? _value.fechaAsignacion
          : fechaAsignacion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SucursalStaffImplCopyWith<$Res>
    implements $SucursalStaffCopyWith<$Res> {
  factory _$$SucursalStaffImplCopyWith(
          _$SucursalStaffImpl value, $Res Function(_$SucursalStaffImpl) then) =
      __$$SucursalStaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int staff,
      String staffNombre,
      int sucursal,
      String sucursalNombre,
      String fechaAsignacion});
}

/// @nodoc
class __$$SucursalStaffImplCopyWithImpl<$Res>
    extends _$SucursalStaffCopyWithImpl<$Res, _$SucursalStaffImpl>
    implements _$$SucursalStaffImplCopyWith<$Res> {
  __$$SucursalStaffImplCopyWithImpl(
      _$SucursalStaffImpl _value, $Res Function(_$SucursalStaffImpl) _then)
      : super(_value, _then);

  /// Create a copy of SucursalStaff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? staff = null,
    Object? staffNombre = null,
    Object? sucursal = null,
    Object? sucursalNombre = null,
    Object? fechaAsignacion = null,
  }) {
    return _then(_$SucursalStaffImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      staff: null == staff
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as int,
      staffNombre: null == staffNombre
          ? _value.staffNombre
          : staffNombre // ignore: cast_nullable_to_non_nullable
              as String,
      sucursal: null == sucursal
          ? _value.sucursal
          : sucursal // ignore: cast_nullable_to_non_nullable
              as int,
      sucursalNombre: null == sucursalNombre
          ? _value.sucursalNombre
          : sucursalNombre // ignore: cast_nullable_to_non_nullable
              as String,
      fechaAsignacion: null == fechaAsignacion
          ? _value.fechaAsignacion
          : fechaAsignacion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SucursalStaffImpl implements _SucursalStaff {
  const _$SucursalStaffImpl(
      {required this.id,
      required this.staff,
      required this.staffNombre,
      required this.sucursal,
      required this.sucursalNombre,
      required this.fechaAsignacion});

  factory _$SucursalStaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$SucursalStaffImplFromJson(json);

  @override
  final int id;
  @override
  final int staff;
  @override
  final String staffNombre;
  @override
  final int sucursal;
  @override
  final String sucursalNombre;
  @override
  final String fechaAsignacion;

  @override
  String toString() {
    return 'SucursalStaff(id: $id, staff: $staff, staffNombre: $staffNombre, sucursal: $sucursal, sucursalNombre: $sucursalNombre, fechaAsignacion: $fechaAsignacion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SucursalStaffImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.staff, staff) || other.staff == staff) &&
            (identical(other.staffNombre, staffNombre) ||
                other.staffNombre == staffNombre) &&
            (identical(other.sucursal, sucursal) ||
                other.sucursal == sucursal) &&
            (identical(other.sucursalNombre, sucursalNombre) ||
                other.sucursalNombre == sucursalNombre) &&
            (identical(other.fechaAsignacion, fechaAsignacion) ||
                other.fechaAsignacion == fechaAsignacion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, staff, staffNombre, sucursal,
      sucursalNombre, fechaAsignacion);

  /// Create a copy of SucursalStaff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SucursalStaffImplCopyWith<_$SucursalStaffImpl> get copyWith =>
      __$$SucursalStaffImplCopyWithImpl<_$SucursalStaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SucursalStaffImplToJson(
      this,
    );
  }
}

abstract class _SucursalStaff implements SucursalStaff {
  const factory _SucursalStaff(
      {required final int id,
      required final int staff,
      required final String staffNombre,
      required final int sucursal,
      required final String sucursalNombre,
      required final String fechaAsignacion}) = _$SucursalStaffImpl;

  factory _SucursalStaff.fromJson(Map<String, dynamic> json) =
      _$SucursalStaffImpl.fromJson;

  @override
  int get id;
  @override
  int get staff;
  @override
  String get staffNombre;
  @override
  int get sucursal;
  @override
  String get sucursalNombre;
  @override
  String get fechaAsignacion;

  /// Create a copy of SucursalStaff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SucursalStaffImplCopyWith<_$SucursalStaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
