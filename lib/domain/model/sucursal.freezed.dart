// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sucursal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sucursal _$SucursalFromJson(Map<String, dynamic> json) {
  return _Sucursal.fromJson(json);
}

/// @nodoc
mixin _$Sucursal {
  int get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String get direccion => throw _privateConstructorUsedError;
  String get ciudad => throw _privateConstructorUsedError;
  String? get telefono => throw _privateConstructorUsedError;

  /// Serializes this Sucursal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sucursal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SucursalCopyWith<Sucursal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SucursalCopyWith<$Res> {
  factory $SucursalCopyWith(Sucursal value, $Res Function(Sucursal) then) =
      _$SucursalCopyWithImpl<$Res, Sucursal>;
  @useResult
  $Res call(
      {int id,
      String nombre,
      String direccion,
      String ciudad,
      String? telefono});
}

/// @nodoc
class _$SucursalCopyWithImpl<$Res, $Val extends Sucursal>
    implements $SucursalCopyWith<$Res> {
  _$SucursalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sucursal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? direccion = null,
    Object? ciudad = null,
    Object? telefono = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      direccion: null == direccion
          ? _value.direccion
          : direccion // ignore: cast_nullable_to_non_nullable
              as String,
      ciudad: null == ciudad
          ? _value.ciudad
          : ciudad // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SucursalImplCopyWith<$Res>
    implements $SucursalCopyWith<$Res> {
  factory _$$SucursalImplCopyWith(
          _$SucursalImpl value, $Res Function(_$SucursalImpl) then) =
      __$$SucursalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String nombre,
      String direccion,
      String ciudad,
      String? telefono});
}

/// @nodoc
class __$$SucursalImplCopyWithImpl<$Res>
    extends _$SucursalCopyWithImpl<$Res, _$SucursalImpl>
    implements _$$SucursalImplCopyWith<$Res> {
  __$$SucursalImplCopyWithImpl(
      _$SucursalImpl _value, $Res Function(_$SucursalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sucursal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? direccion = null,
    Object? ciudad = null,
    Object? telefono = freezed,
  }) {
    return _then(_$SucursalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      direccion: null == direccion
          ? _value.direccion
          : direccion // ignore: cast_nullable_to_non_nullable
              as String,
      ciudad: null == ciudad
          ? _value.ciudad
          : ciudad // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SucursalImpl implements _Sucursal {
  const _$SucursalImpl(
      {required this.id,
      required this.nombre,
      required this.direccion,
      required this.ciudad,
      this.telefono});

  factory _$SucursalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SucursalImplFromJson(json);

  @override
  final int id;
  @override
  final String nombre;
  @override
  final String direccion;
  @override
  final String ciudad;
  @override
  final String? telefono;

  @override
  String toString() {
    return 'Sucursal(id: $id, nombre: $nombre, direccion: $direccion, ciudad: $ciudad, telefono: $telefono)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SucursalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.direccion, direccion) ||
                other.direccion == direccion) &&
            (identical(other.ciudad, ciudad) || other.ciudad == ciudad) &&
            (identical(other.telefono, telefono) ||
                other.telefono == telefono));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nombre, direccion, ciudad, telefono);

  /// Create a copy of Sucursal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SucursalImplCopyWith<_$SucursalImpl> get copyWith =>
      __$$SucursalImplCopyWithImpl<_$SucursalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SucursalImplToJson(
      this,
    );
  }
}

abstract class _Sucursal implements Sucursal {
  const factory _Sucursal(
      {required final int id,
      required final String nombre,
      required final String direccion,
      required final String ciudad,
      final String? telefono}) = _$SucursalImpl;

  factory _Sucursal.fromJson(Map<String, dynamic> json) =
      _$SucursalImpl.fromJson;

  @override
  int get id;
  @override
  String get nombre;
  @override
  String get direccion;
  @override
  String get ciudad;
  @override
  String? get telefono;

  /// Create a copy of Sucursal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SucursalImplCopyWith<_$SucursalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
