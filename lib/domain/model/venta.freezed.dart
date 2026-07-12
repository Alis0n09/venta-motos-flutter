// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Venta _$VentaFromJson(Map<String, dynamic> json) {
  return _Venta.fromJson(json);
}

/// @nodoc
mixin _$Venta {
  int get id => throw _privateConstructorUsedError;
  String? get clienteNombre => throw _privateConstructorUsedError;
  String? get vendedorNombre => throw _privateConstructorUsedError;
  DateTime get fechaVenta => throw _privateConstructorUsedError;
  String get metodoPago => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  int get unidadesVendidas => throw _privateConstructorUsedError;

  /// Serializes this Venta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Venta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VentaCopyWith<Venta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VentaCopyWith<$Res> {
  factory $VentaCopyWith(Venta value, $Res Function(Venta) then) =
      _$VentaCopyWithImpl<$Res, Venta>;
  @useResult
  $Res call(
      {int id,
      String? clienteNombre,
      String? vendedorNombre,
      DateTime fechaVenta,
      String metodoPago,
      double total,
      int unidadesVendidas});
}

/// @nodoc
class _$VentaCopyWithImpl<$Res, $Val extends Venta>
    implements $VentaCopyWith<$Res> {
  _$VentaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Venta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clienteNombre = freezed,
    Object? vendedorNombre = freezed,
    Object? fechaVenta = null,
    Object? metodoPago = null,
    Object? total = null,
    Object? unidadesVendidas = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      vendedorNombre: freezed == vendedorNombre
          ? _value.vendedorNombre
          : vendedorNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      fechaVenta: null == fechaVenta
          ? _value.fechaVenta
          : fechaVenta // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metodoPago: null == metodoPago
          ? _value.metodoPago
          : metodoPago // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      unidadesVendidas: null == unidadesVendidas
          ? _value.unidadesVendidas
          : unidadesVendidas // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VentaImplCopyWith<$Res> implements $VentaCopyWith<$Res> {
  factory _$$VentaImplCopyWith(
          _$VentaImpl value, $Res Function(_$VentaImpl) then) =
      __$$VentaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? clienteNombre,
      String? vendedorNombre,
      DateTime fechaVenta,
      String metodoPago,
      double total,
      int unidadesVendidas});
}

/// @nodoc
class __$$VentaImplCopyWithImpl<$Res>
    extends _$VentaCopyWithImpl<$Res, _$VentaImpl>
    implements _$$VentaImplCopyWith<$Res> {
  __$$VentaImplCopyWithImpl(
      _$VentaImpl _value, $Res Function(_$VentaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Venta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clienteNombre = freezed,
    Object? vendedorNombre = freezed,
    Object? fechaVenta = null,
    Object? metodoPago = null,
    Object? total = null,
    Object? unidadesVendidas = null,
  }) {
    return _then(_$VentaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      vendedorNombre: freezed == vendedorNombre
          ? _value.vendedorNombre
          : vendedorNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      fechaVenta: null == fechaVenta
          ? _value.fechaVenta
          : fechaVenta // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metodoPago: null == metodoPago
          ? _value.metodoPago
          : metodoPago // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      unidadesVendidas: null == unidadesVendidas
          ? _value.unidadesVendidas
          : unidadesVendidas // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VentaImpl implements _Venta {
  const _$VentaImpl(
      {required this.id,
      this.clienteNombre,
      this.vendedorNombre,
      required this.fechaVenta,
      required this.metodoPago,
      required this.total,
      required this.unidadesVendidas});

  factory _$VentaImpl.fromJson(Map<String, dynamic> json) =>
      _$$VentaImplFromJson(json);

  @override
  final int id;
  @override
  final String? clienteNombre;
  @override
  final String? vendedorNombre;
  @override
  final DateTime fechaVenta;
  @override
  final String metodoPago;
  @override
  final double total;
  @override
  final int unidadesVendidas;

  @override
  String toString() {
    return 'Venta(id: $id, clienteNombre: $clienteNombre, vendedorNombre: $vendedorNombre, fechaVenta: $fechaVenta, metodoPago: $metodoPago, total: $total, unidadesVendidas: $unidadesVendidas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VentaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clienteNombre, clienteNombre) ||
                other.clienteNombre == clienteNombre) &&
            (identical(other.vendedorNombre, vendedorNombre) ||
                other.vendedorNombre == vendedorNombre) &&
            (identical(other.fechaVenta, fechaVenta) ||
                other.fechaVenta == fechaVenta) &&
            (identical(other.metodoPago, metodoPago) ||
                other.metodoPago == metodoPago) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.unidadesVendidas, unidadesVendidas) ||
                other.unidadesVendidas == unidadesVendidas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, clienteNombre,
      vendedorNombre, fechaVenta, metodoPago, total, unidadesVendidas);

  /// Create a copy of Venta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VentaImplCopyWith<_$VentaImpl> get copyWith =>
      __$$VentaImplCopyWithImpl<_$VentaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VentaImplToJson(
      this,
    );
  }
}

abstract class _Venta implements Venta {
  const factory _Venta(
      {required final int id,
      final String? clienteNombre,
      final String? vendedorNombre,
      required final DateTime fechaVenta,
      required final String metodoPago,
      required final double total,
      required final int unidadesVendidas}) = _$VentaImpl;

  factory _Venta.fromJson(Map<String, dynamic> json) = _$VentaImpl.fromJson;

  @override
  int get id;
  @override
  String? get clienteNombre;
  @override
  String? get vendedorNombre;
  @override
  DateTime get fechaVenta;
  @override
  String get metodoPago;
  @override
  double get total;
  @override
  int get unidadesVendidas;

  /// Create a copy of Venta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VentaImplCopyWith<_$VentaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
