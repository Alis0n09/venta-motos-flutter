// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financiamiento.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Financiamiento _$FinanciamientoFromJson(Map<String, dynamic> json) {
  return _Financiamiento.fromJson(json);
}

/// @nodoc
mixin _$Financiamiento {
  int get id => throw _privateConstructorUsedError;
  int get venta => throw _privateConstructorUsedError;
  String? get clienteNombre => throw _privateConstructorUsedError;
  String? get clienteCedula => throw _privateConstructorUsedError;
  List<String> get motoDetalle => throw _privateConstructorUsedError;
  double get montoFinanciado => throw _privateConstructorUsedError;
  double get tasaInteres => throw _privateConstructorUsedError;
  int get plazoMeses => throw _privateConstructorUsedError;
  DateTime get fechaInicio => throw _privateConstructorUsedError;
  DateTime? get fechaFin => throw _privateConstructorUsedError;
  String get estado => throw _privateConstructorUsedError;
  double? get cuotaMensual => throw _privateConstructorUsedError;

  /// Serializes this Financiamiento to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Financiamiento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinanciamientoCopyWith<Financiamiento> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinanciamientoCopyWith<$Res> {
  factory $FinanciamientoCopyWith(
          Financiamiento value, $Res Function(Financiamiento) then) =
      _$FinanciamientoCopyWithImpl<$Res, Financiamiento>;
  @useResult
  $Res call(
      {int id,
      int venta,
      String? clienteNombre,
      String? clienteCedula,
      List<String> motoDetalle,
      double montoFinanciado,
      double tasaInteres,
      int plazoMeses,
      DateTime fechaInicio,
      DateTime? fechaFin,
      String estado,
      double? cuotaMensual});
}

/// @nodoc
class _$FinanciamientoCopyWithImpl<$Res, $Val extends Financiamiento>
    implements $FinanciamientoCopyWith<$Res> {
  _$FinanciamientoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Financiamiento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? venta = null,
    Object? clienteNombre = freezed,
    Object? clienteCedula = freezed,
    Object? motoDetalle = null,
    Object? montoFinanciado = null,
    Object? tasaInteres = null,
    Object? plazoMeses = null,
    Object? fechaInicio = null,
    Object? fechaFin = freezed,
    Object? estado = null,
    Object? cuotaMensual = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      venta: null == venta
          ? _value.venta
          : venta // ignore: cast_nullable_to_non_nullable
              as int,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteCedula: freezed == clienteCedula
          ? _value.clienteCedula
          : clienteCedula // ignore: cast_nullable_to_non_nullable
              as String?,
      motoDetalle: null == motoDetalle
          ? _value.motoDetalle
          : motoDetalle // ignore: cast_nullable_to_non_nullable
              as List<String>,
      montoFinanciado: null == montoFinanciado
          ? _value.montoFinanciado
          : montoFinanciado // ignore: cast_nullable_to_non_nullable
              as double,
      tasaInteres: null == tasaInteres
          ? _value.tasaInteres
          : tasaInteres // ignore: cast_nullable_to_non_nullable
              as double,
      plazoMeses: null == plazoMeses
          ? _value.plazoMeses
          : plazoMeses // ignore: cast_nullable_to_non_nullable
              as int,
      fechaInicio: null == fechaInicio
          ? _value.fechaInicio
          : fechaInicio // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFin: freezed == fechaFin
          ? _value.fechaFin
          : fechaFin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as String,
      cuotaMensual: freezed == cuotaMensual
          ? _value.cuotaMensual
          : cuotaMensual // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinanciamientoImplCopyWith<$Res>
    implements $FinanciamientoCopyWith<$Res> {
  factory _$$FinanciamientoImplCopyWith(_$FinanciamientoImpl value,
          $Res Function(_$FinanciamientoImpl) then) =
      __$$FinanciamientoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int venta,
      String? clienteNombre,
      String? clienteCedula,
      List<String> motoDetalle,
      double montoFinanciado,
      double tasaInteres,
      int plazoMeses,
      DateTime fechaInicio,
      DateTime? fechaFin,
      String estado,
      double? cuotaMensual});
}

/// @nodoc
class __$$FinanciamientoImplCopyWithImpl<$Res>
    extends _$FinanciamientoCopyWithImpl<$Res, _$FinanciamientoImpl>
    implements _$$FinanciamientoImplCopyWith<$Res> {
  __$$FinanciamientoImplCopyWithImpl(
      _$FinanciamientoImpl _value, $Res Function(_$FinanciamientoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Financiamiento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? venta = null,
    Object? clienteNombre = freezed,
    Object? clienteCedula = freezed,
    Object? motoDetalle = null,
    Object? montoFinanciado = null,
    Object? tasaInteres = null,
    Object? plazoMeses = null,
    Object? fechaInicio = null,
    Object? fechaFin = freezed,
    Object? estado = null,
    Object? cuotaMensual = freezed,
  }) {
    return _then(_$FinanciamientoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      venta: null == venta
          ? _value.venta
          : venta // ignore: cast_nullable_to_non_nullable
              as int,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteCedula: freezed == clienteCedula
          ? _value.clienteCedula
          : clienteCedula // ignore: cast_nullable_to_non_nullable
              as String?,
      motoDetalle: null == motoDetalle
          ? _value._motoDetalle
          : motoDetalle // ignore: cast_nullable_to_non_nullable
              as List<String>,
      montoFinanciado: null == montoFinanciado
          ? _value.montoFinanciado
          : montoFinanciado // ignore: cast_nullable_to_non_nullable
              as double,
      tasaInteres: null == tasaInteres
          ? _value.tasaInteres
          : tasaInteres // ignore: cast_nullable_to_non_nullable
              as double,
      plazoMeses: null == plazoMeses
          ? _value.plazoMeses
          : plazoMeses // ignore: cast_nullable_to_non_nullable
              as int,
      fechaInicio: null == fechaInicio
          ? _value.fechaInicio
          : fechaInicio // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFin: freezed == fechaFin
          ? _value.fechaFin
          : fechaFin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as String,
      cuotaMensual: freezed == cuotaMensual
          ? _value.cuotaMensual
          : cuotaMensual // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinanciamientoImpl implements _Financiamiento {
  const _$FinanciamientoImpl(
      {required this.id,
      required this.venta,
      this.clienteNombre,
      this.clienteCedula,
      final List<String> motoDetalle = const <String>[],
      required this.montoFinanciado,
      required this.tasaInteres,
      required this.plazoMeses,
      required this.fechaInicio,
      this.fechaFin,
      required this.estado,
      this.cuotaMensual})
      : _motoDetalle = motoDetalle;

  factory _$FinanciamientoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinanciamientoImplFromJson(json);

  @override
  final int id;
  @override
  final int venta;
  @override
  final String? clienteNombre;
  @override
  final String? clienteCedula;
  final List<String> _motoDetalle;
  @override
  @JsonKey()
  List<String> get motoDetalle {
    if (_motoDetalle is EqualUnmodifiableListView) return _motoDetalle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_motoDetalle);
  }

  @override
  final double montoFinanciado;
  @override
  final double tasaInteres;
  @override
  final int plazoMeses;
  @override
  final DateTime fechaInicio;
  @override
  final DateTime? fechaFin;
  @override
  final String estado;
  @override
  final double? cuotaMensual;

  @override
  String toString() {
    return 'Financiamiento(id: $id, venta: $venta, clienteNombre: $clienteNombre, clienteCedula: $clienteCedula, motoDetalle: $motoDetalle, montoFinanciado: $montoFinanciado, tasaInteres: $tasaInteres, plazoMeses: $plazoMeses, fechaInicio: $fechaInicio, fechaFin: $fechaFin, estado: $estado, cuotaMensual: $cuotaMensual)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinanciamientoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.venta, venta) || other.venta == venta) &&
            (identical(other.clienteNombre, clienteNombre) ||
                other.clienteNombre == clienteNombre) &&
            (identical(other.clienteCedula, clienteCedula) ||
                other.clienteCedula == clienteCedula) &&
            const DeepCollectionEquality()
                .equals(other._motoDetalle, _motoDetalle) &&
            (identical(other.montoFinanciado, montoFinanciado) ||
                other.montoFinanciado == montoFinanciado) &&
            (identical(other.tasaInteres, tasaInteres) ||
                other.tasaInteres == tasaInteres) &&
            (identical(other.plazoMeses, plazoMeses) ||
                other.plazoMeses == plazoMeses) &&
            (identical(other.fechaInicio, fechaInicio) ||
                other.fechaInicio == fechaInicio) &&
            (identical(other.fechaFin, fechaFin) ||
                other.fechaFin == fechaFin) &&
            (identical(other.estado, estado) || other.estado == estado) &&
            (identical(other.cuotaMensual, cuotaMensual) ||
                other.cuotaMensual == cuotaMensual));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      venta,
      clienteNombre,
      clienteCedula,
      const DeepCollectionEquality().hash(_motoDetalle),
      montoFinanciado,
      tasaInteres,
      plazoMeses,
      fechaInicio,
      fechaFin,
      estado,
      cuotaMensual);

  /// Create a copy of Financiamiento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinanciamientoImplCopyWith<_$FinanciamientoImpl> get copyWith =>
      __$$FinanciamientoImplCopyWithImpl<_$FinanciamientoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinanciamientoImplToJson(
      this,
    );
  }
}

abstract class _Financiamiento implements Financiamiento {
  const factory _Financiamiento(
      {required final int id,
      required final int venta,
      final String? clienteNombre,
      final String? clienteCedula,
      final List<String> motoDetalle,
      required final double montoFinanciado,
      required final double tasaInteres,
      required final int plazoMeses,
      required final DateTime fechaInicio,
      final DateTime? fechaFin,
      required final String estado,
      final double? cuotaMensual}) = _$FinanciamientoImpl;

  factory _Financiamiento.fromJson(Map<String, dynamic> json) =
      _$FinanciamientoImpl.fromJson;

  @override
  int get id;
  @override
  int get venta;
  @override
  String? get clienteNombre;
  @override
  String? get clienteCedula;
  @override
  List<String> get motoDetalle;
  @override
  double get montoFinanciado;
  @override
  double get tasaInteres;
  @override
  int get plazoMeses;
  @override
  DateTime get fechaInicio;
  @override
  DateTime? get fechaFin;
  @override
  String get estado;
  @override
  double? get cuotaMensual;

  /// Create a copy of Financiamiento
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinanciamientoImplCopyWith<_$FinanciamientoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
