// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detalle_compra.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DetalleCompra _$DetalleCompraFromJson(Map<String, dynamic> json) {
  return _DetalleCompra.fromJson(json);
}

/// @nodoc
mixin _$DetalleCompra {
  int get id => throw _privateConstructorUsedError;
  int get compra => throw _privateConstructorUsedError;
  int get moto => throw _privateConstructorUsedError;
  int get cantidad => throw _privateConstructorUsedError;
  double get precioCosto => throw _privateConstructorUsedError;

  /// Serializes this DetalleCompra to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetalleCompra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetalleCompraCopyWith<DetalleCompra> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetalleCompraCopyWith<$Res> {
  factory $DetalleCompraCopyWith(
          DetalleCompra value, $Res Function(DetalleCompra) then) =
      _$DetalleCompraCopyWithImpl<$Res, DetalleCompra>;
  @useResult
  $Res call({int id, int compra, int moto, int cantidad, double precioCosto});
}

/// @nodoc
class _$DetalleCompraCopyWithImpl<$Res, $Val extends DetalleCompra>
    implements $DetalleCompraCopyWith<$Res> {
  _$DetalleCompraCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetalleCompra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compra = null,
    Object? moto = null,
    Object? cantidad = null,
    Object? precioCosto = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      compra: null == compra
          ? _value.compra
          : compra // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      cantidad: null == cantidad
          ? _value.cantidad
          : cantidad // ignore: cast_nullable_to_non_nullable
              as int,
      precioCosto: null == precioCosto
          ? _value.precioCosto
          : precioCosto // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DetalleCompraImplCopyWith<$Res>
    implements $DetalleCompraCopyWith<$Res> {
  factory _$$DetalleCompraImplCopyWith(
          _$DetalleCompraImpl value, $Res Function(_$DetalleCompraImpl) then) =
      __$$DetalleCompraImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int compra, int moto, int cantidad, double precioCosto});
}

/// @nodoc
class __$$DetalleCompraImplCopyWithImpl<$Res>
    extends _$DetalleCompraCopyWithImpl<$Res, _$DetalleCompraImpl>
    implements _$$DetalleCompraImplCopyWith<$Res> {
  __$$DetalleCompraImplCopyWithImpl(
      _$DetalleCompraImpl _value, $Res Function(_$DetalleCompraImpl) _then)
      : super(_value, _then);

  /// Create a copy of DetalleCompra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compra = null,
    Object? moto = null,
    Object? cantidad = null,
    Object? precioCosto = null,
  }) {
    return _then(_$DetalleCompraImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      compra: null == compra
          ? _value.compra
          : compra // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      cantidad: null == cantidad
          ? _value.cantidad
          : cantidad // ignore: cast_nullable_to_non_nullable
              as int,
      precioCosto: null == precioCosto
          ? _value.precioCosto
          : precioCosto // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetalleCompraImpl implements _DetalleCompra {
  const _$DetalleCompraImpl(
      {required this.id,
      required this.compra,
      required this.moto,
      required this.cantidad,
      required this.precioCosto});

  factory _$DetalleCompraImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetalleCompraImplFromJson(json);

  @override
  final int id;
  @override
  final int compra;
  @override
  final int moto;
  @override
  final int cantidad;
  @override
  final double precioCosto;

  @override
  String toString() {
    return 'DetalleCompra(id: $id, compra: $compra, moto: $moto, cantidad: $cantidad, precioCosto: $precioCosto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetalleCompraImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.compra, compra) || other.compra == compra) &&
            (identical(other.moto, moto) || other.moto == moto) &&
            (identical(other.cantidad, cantidad) ||
                other.cantidad == cantidad) &&
            (identical(other.precioCosto, precioCosto) ||
                other.precioCosto == precioCosto));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, compra, moto, cantidad, precioCosto);

  /// Create a copy of DetalleCompra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetalleCompraImplCopyWith<_$DetalleCompraImpl> get copyWith =>
      __$$DetalleCompraImplCopyWithImpl<_$DetalleCompraImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetalleCompraImplToJson(
      this,
    );
  }
}

abstract class _DetalleCompra implements DetalleCompra {
  const factory _DetalleCompra(
      {required final int id,
      required final int compra,
      required final int moto,
      required final int cantidad,
      required final double precioCosto}) = _$DetalleCompraImpl;

  factory _DetalleCompra.fromJson(Map<String, dynamic> json) =
      _$DetalleCompraImpl.fromJson;

  @override
  int get id;
  @override
  int get compra;
  @override
  int get moto;
  @override
  int get cantidad;
  @override
  double get precioCosto;

  /// Create a copy of DetalleCompra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetalleCompraImplCopyWith<_$DetalleCompraImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
