// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Inventario _$InventarioFromJson(Map<String, dynamic> json) {
  return _Inventario.fromJson(json);
}

/// @nodoc
mixin _$Inventario {
  int get id => throw _privateConstructorUsedError;
  int get moto => throw _privateConstructorUsedError;
  String get motoNombre => throw _privateConstructorUsedError;
  int get sucursal => throw _privateConstructorUsedError;
  String get sucursalNombre => throw _privateConstructorUsedError;
  int get cantidad => throw _privateConstructorUsedError;
  String? get ubicacionBodega => throw _privateConstructorUsedError;

  /// Serializes this Inventario to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Inventario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventarioCopyWith<Inventario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventarioCopyWith<$Res> {
  factory $InventarioCopyWith(
          Inventario value, $Res Function(Inventario) then) =
      _$InventarioCopyWithImpl<$Res, Inventario>;
  @useResult
  $Res call(
      {int id,
      int moto,
      String motoNombre,
      int sucursal,
      String sucursalNombre,
      int cantidad,
      String? ubicacionBodega});
}

/// @nodoc
class _$InventarioCopyWithImpl<$Res, $Val extends Inventario>
    implements $InventarioCopyWith<$Res> {
  _$InventarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Inventario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoNombre = null,
    Object? sucursal = null,
    Object? sucursalNombre = null,
    Object? cantidad = null,
    Object? ubicacionBodega = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      motoNombre: null == motoNombre
          ? _value.motoNombre
          : motoNombre // ignore: cast_nullable_to_non_nullable
              as String,
      sucursal: null == sucursal
          ? _value.sucursal
          : sucursal // ignore: cast_nullable_to_non_nullable
              as int,
      sucursalNombre: null == sucursalNombre
          ? _value.sucursalNombre
          : sucursalNombre // ignore: cast_nullable_to_non_nullable
              as String,
      cantidad: null == cantidad
          ? _value.cantidad
          : cantidad // ignore: cast_nullable_to_non_nullable
              as int,
      ubicacionBodega: freezed == ubicacionBodega
          ? _value.ubicacionBodega
          : ubicacionBodega // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventarioImplCopyWith<$Res>
    implements $InventarioCopyWith<$Res> {
  factory _$$InventarioImplCopyWith(
          _$InventarioImpl value, $Res Function(_$InventarioImpl) then) =
      __$$InventarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int moto,
      String motoNombre,
      int sucursal,
      String sucursalNombre,
      int cantidad,
      String? ubicacionBodega});
}

/// @nodoc
class __$$InventarioImplCopyWithImpl<$Res>
    extends _$InventarioCopyWithImpl<$Res, _$InventarioImpl>
    implements _$$InventarioImplCopyWith<$Res> {
  __$$InventarioImplCopyWithImpl(
      _$InventarioImpl _value, $Res Function(_$InventarioImpl) _then)
      : super(_value, _then);

  /// Create a copy of Inventario
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoNombre = null,
    Object? sucursal = null,
    Object? sucursalNombre = null,
    Object? cantidad = null,
    Object? ubicacionBodega = freezed,
  }) {
    return _then(_$InventarioImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      motoNombre: null == motoNombre
          ? _value.motoNombre
          : motoNombre // ignore: cast_nullable_to_non_nullable
              as String,
      sucursal: null == sucursal
          ? _value.sucursal
          : sucursal // ignore: cast_nullable_to_non_nullable
              as int,
      sucursalNombre: null == sucursalNombre
          ? _value.sucursalNombre
          : sucursalNombre // ignore: cast_nullable_to_non_nullable
              as String,
      cantidad: null == cantidad
          ? _value.cantidad
          : cantidad // ignore: cast_nullable_to_non_nullable
              as int,
      ubicacionBodega: freezed == ubicacionBodega
          ? _value.ubicacionBodega
          : ubicacionBodega // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventarioImpl implements _Inventario {
  const _$InventarioImpl(
      {required this.id,
      required this.moto,
      required this.motoNombre,
      required this.sucursal,
      required this.sucursalNombre,
      required this.cantidad,
      this.ubicacionBodega});

  factory _$InventarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventarioImplFromJson(json);

  @override
  final int id;
  @override
  final int moto;
  @override
  final String motoNombre;
  @override
  final int sucursal;
  @override
  final String sucursalNombre;
  @override
  final int cantidad;
  @override
  final String? ubicacionBodega;

  @override
  String toString() {
    return 'Inventario(id: $id, moto: $moto, motoNombre: $motoNombre, sucursal: $sucursal, sucursalNombre: $sucursalNombre, cantidad: $cantidad, ubicacionBodega: $ubicacionBodega)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventarioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.moto, moto) || other.moto == moto) &&
            (identical(other.motoNombre, motoNombre) ||
                other.motoNombre == motoNombre) &&
            (identical(other.sucursal, sucursal) ||
                other.sucursal == sucursal) &&
            (identical(other.sucursalNombre, sucursalNombre) ||
                other.sucursalNombre == sucursalNombre) &&
            (identical(other.cantidad, cantidad) ||
                other.cantidad == cantidad) &&
            (identical(other.ubicacionBodega, ubicacionBodega) ||
                other.ubicacionBodega == ubicacionBodega));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, moto, motoNombre, sucursal,
      sucursalNombre, cantidad, ubicacionBodega);

  /// Create a copy of Inventario
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventarioImplCopyWith<_$InventarioImpl> get copyWith =>
      __$$InventarioImplCopyWithImpl<_$InventarioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventarioImplToJson(
      this,
    );
  }
}

abstract class _Inventario implements Inventario {
  const factory _Inventario(
      {required final int id,
      required final int moto,
      required final String motoNombre,
      required final int sucursal,
      required final String sucursalNombre,
      required final int cantidad,
      final String? ubicacionBodega}) = _$InventarioImpl;

  factory _Inventario.fromJson(Map<String, dynamic> json) =
      _$InventarioImpl.fromJson;

  @override
  int get id;
  @override
  int get moto;
  @override
  String get motoNombre;
  @override
  int get sucursal;
  @override
  String get sucursalNombre;
  @override
  int get cantidad;
  @override
  String? get ubicacionBodega;

  /// Create a copy of Inventario
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventarioImplCopyWith<_$InventarioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
