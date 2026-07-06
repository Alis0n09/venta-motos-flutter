// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cuota_pago.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CuotaPago _$CuotaPagoFromJson(Map<String, dynamic> json) {
  return _CuotaPago.fromJson(json);
}

/// @nodoc
mixin _$CuotaPago {
  int get id => throw _privateConstructorUsedError;
  int get financiamiento => throw _privateConstructorUsedError;
  int get numeroCuota => throw _privateConstructorUsedError;
  DateTime get fechaVencimiento => throw _privateConstructorUsedError;
  DateTime? get fechaPago => throw _privateConstructorUsedError;
  double get monto => throw _privateConstructorUsedError;
  String get estado => throw _privateConstructorUsedError;

  /// Serializes this CuotaPago to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CuotaPago
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CuotaPagoCopyWith<CuotaPago> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CuotaPagoCopyWith<$Res> {
  factory $CuotaPagoCopyWith(CuotaPago value, $Res Function(CuotaPago) then) =
      _$CuotaPagoCopyWithImpl<$Res, CuotaPago>;
  @useResult
  $Res call(
      {int id,
      int financiamiento,
      int numeroCuota,
      DateTime fechaVencimiento,
      DateTime? fechaPago,
      double monto,
      String estado});
}

/// @nodoc
class _$CuotaPagoCopyWithImpl<$Res, $Val extends CuotaPago>
    implements $CuotaPagoCopyWith<$Res> {
  _$CuotaPagoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CuotaPago
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? financiamiento = null,
    Object? numeroCuota = null,
    Object? fechaVencimiento = null,
    Object? fechaPago = freezed,
    Object? monto = null,
    Object? estado = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      financiamiento: null == financiamiento
          ? _value.financiamiento
          : financiamiento // ignore: cast_nullable_to_non_nullable
              as int,
      numeroCuota: null == numeroCuota
          ? _value.numeroCuota
          : numeroCuota // ignore: cast_nullable_to_non_nullable
              as int,
      fechaVencimiento: null == fechaVencimiento
          ? _value.fechaVencimiento
          : fechaVencimiento // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaPago: freezed == fechaPago
          ? _value.fechaPago
          : fechaPago // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      monto: null == monto
          ? _value.monto
          : monto // ignore: cast_nullable_to_non_nullable
              as double,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CuotaPagoImplCopyWith<$Res>
    implements $CuotaPagoCopyWith<$Res> {
  factory _$$CuotaPagoImplCopyWith(
          _$CuotaPagoImpl value, $Res Function(_$CuotaPagoImpl) then) =
      __$$CuotaPagoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int financiamiento,
      int numeroCuota,
      DateTime fechaVencimiento,
      DateTime? fechaPago,
      double monto,
      String estado});
}

/// @nodoc
class __$$CuotaPagoImplCopyWithImpl<$Res>
    extends _$CuotaPagoCopyWithImpl<$Res, _$CuotaPagoImpl>
    implements _$$CuotaPagoImplCopyWith<$Res> {
  __$$CuotaPagoImplCopyWithImpl(
      _$CuotaPagoImpl _value, $Res Function(_$CuotaPagoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CuotaPago
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? financiamiento = null,
    Object? numeroCuota = null,
    Object? fechaVencimiento = null,
    Object? fechaPago = freezed,
    Object? monto = null,
    Object? estado = null,
  }) {
    return _then(_$CuotaPagoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      financiamiento: null == financiamiento
          ? _value.financiamiento
          : financiamiento // ignore: cast_nullable_to_non_nullable
              as int,
      numeroCuota: null == numeroCuota
          ? _value.numeroCuota
          : numeroCuota // ignore: cast_nullable_to_non_nullable
              as int,
      fechaVencimiento: null == fechaVencimiento
          ? _value.fechaVencimiento
          : fechaVencimiento // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaPago: freezed == fechaPago
          ? _value.fechaPago
          : fechaPago // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      monto: null == monto
          ? _value.monto
          : monto // ignore: cast_nullable_to_non_nullable
              as double,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CuotaPagoImpl implements _CuotaPago {
  const _$CuotaPagoImpl(
      {required this.id,
      required this.financiamiento,
      required this.numeroCuota,
      required this.fechaVencimiento,
      this.fechaPago,
      required this.monto,
      required this.estado});

  factory _$CuotaPagoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CuotaPagoImplFromJson(json);

  @override
  final int id;
  @override
  final int financiamiento;
  @override
  final int numeroCuota;
  @override
  final DateTime fechaVencimiento;
  @override
  final DateTime? fechaPago;
  @override
  final double monto;
  @override
  final String estado;

  @override
  String toString() {
    return 'CuotaPago(id: $id, financiamiento: $financiamiento, numeroCuota: $numeroCuota, fechaVencimiento: $fechaVencimiento, fechaPago: $fechaPago, monto: $monto, estado: $estado)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CuotaPagoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.financiamiento, financiamiento) ||
                other.financiamiento == financiamiento) &&
            (identical(other.numeroCuota, numeroCuota) ||
                other.numeroCuota == numeroCuota) &&
            (identical(other.fechaVencimiento, fechaVencimiento) ||
                other.fechaVencimiento == fechaVencimiento) &&
            (identical(other.fechaPago, fechaPago) ||
                other.fechaPago == fechaPago) &&
            (identical(other.monto, monto) || other.monto == monto) &&
            (identical(other.estado, estado) || other.estado == estado));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, financiamiento, numeroCuota,
      fechaVencimiento, fechaPago, monto, estado);

  /// Create a copy of CuotaPago
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CuotaPagoImplCopyWith<_$CuotaPagoImpl> get copyWith =>
      __$$CuotaPagoImplCopyWithImpl<_$CuotaPagoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CuotaPagoImplToJson(
      this,
    );
  }
}

abstract class _CuotaPago implements CuotaPago {
  const factory _CuotaPago(
      {required final int id,
      required final int financiamiento,
      required final int numeroCuota,
      required final DateTime fechaVencimiento,
      final DateTime? fechaPago,
      required final double monto,
      required final String estado}) = _$CuotaPagoImpl;

  factory _CuotaPago.fromJson(Map<String, dynamic> json) =
      _$CuotaPagoImpl.fromJson;

  @override
  int get id;
  @override
  int get financiamiento;
  @override
  int get numeroCuota;
  @override
  DateTime get fechaVencimiento;
  @override
  DateTime? get fechaPago;
  @override
  double get monto;
  @override
  String get estado;

  /// Create a copy of CuotaPago
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CuotaPagoImplCopyWith<_$CuotaPagoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
