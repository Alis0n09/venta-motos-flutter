// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compra.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Compra _$CompraFromJson(Map<String, dynamic> json) {
  return _Compra.fromJson(json);
}

/// @nodoc
mixin _$Compra {
  int get id => throw _privateConstructorUsedError;
  int get proveedor => throw _privateConstructorUsedError;
  int get sucursalDestino => throw _privateConstructorUsedError;
  String get fecha => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  /// Serializes this Compra to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Compra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompraCopyWith<Compra> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompraCopyWith<$Res> {
  factory $CompraCopyWith(Compra value, $Res Function(Compra) then) =
      _$CompraCopyWithImpl<$Res, Compra>;
  @useResult
  $Res call(
      {int id, int proveedor, int sucursalDestino, String fecha, double total});
}

/// @nodoc
class _$CompraCopyWithImpl<$Res, $Val extends Compra>
    implements $CompraCopyWith<$Res> {
  _$CompraCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Compra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? proveedor = null,
    Object? sucursalDestino = null,
    Object? fecha = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      proveedor: null == proveedor
          ? _value.proveedor
          : proveedor // ignore: cast_nullable_to_non_nullable
              as int,
      sucursalDestino: null == sucursalDestino
          ? _value.sucursalDestino
          : sucursalDestino // ignore: cast_nullable_to_non_nullable
              as int,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompraImplCopyWith<$Res> implements $CompraCopyWith<$Res> {
  factory _$$CompraImplCopyWith(
          _$CompraImpl value, $Res Function(_$CompraImpl) then) =
      __$$CompraImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, int proveedor, int sucursalDestino, String fecha, double total});
}

/// @nodoc
class __$$CompraImplCopyWithImpl<$Res>
    extends _$CompraCopyWithImpl<$Res, _$CompraImpl>
    implements _$$CompraImplCopyWith<$Res> {
  __$$CompraImplCopyWithImpl(
      _$CompraImpl _value, $Res Function(_$CompraImpl) _then)
      : super(_value, _then);

  /// Create a copy of Compra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? proveedor = null,
    Object? sucursalDestino = null,
    Object? fecha = null,
    Object? total = null,
  }) {
    return _then(_$CompraImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      proveedor: null == proveedor
          ? _value.proveedor
          : proveedor // ignore: cast_nullable_to_non_nullable
              as int,
      sucursalDestino: null == sucursalDestino
          ? _value.sucursalDestino
          : sucursalDestino // ignore: cast_nullable_to_non_nullable
              as int,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompraImpl implements _Compra {
  const _$CompraImpl(
      {required this.id,
      required this.proveedor,
      required this.sucursalDestino,
      required this.fecha,
      required this.total});

  factory _$CompraImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompraImplFromJson(json);

  @override
  final int id;
  @override
  final int proveedor;
  @override
  final int sucursalDestino;
  @override
  final String fecha;
  @override
  final double total;

  @override
  String toString() {
    return 'Compra(id: $id, proveedor: $proveedor, sucursalDestino: $sucursalDestino, fecha: $fecha, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompraImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.proveedor, proveedor) ||
                other.proveedor == proveedor) &&
            (identical(other.sucursalDestino, sucursalDestino) ||
                other.sucursalDestino == sucursalDestino) &&
            (identical(other.fecha, fecha) || other.fecha == fecha) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, proveedor, sucursalDestino, fecha, total);

  /// Create a copy of Compra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompraImplCopyWith<_$CompraImpl> get copyWith =>
      __$$CompraImplCopyWithImpl<_$CompraImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompraImplToJson(
      this,
    );
  }
}

abstract class _Compra implements Compra {
  const factory _Compra(
      {required final int id,
      required final int proveedor,
      required final int sucursalDestino,
      required final String fecha,
      required final double total}) = _$CompraImpl;

  factory _Compra.fromJson(Map<String, dynamic> json) = _$CompraImpl.fromJson;

  @override
  int get id;
  @override
  int get proveedor;
  @override
  int get sucursalDestino;
  @override
  String get fecha;
  @override
  double get total;

  /// Create a copy of Compra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompraImplCopyWith<_$CompraImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
