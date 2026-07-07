// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mantenimiento.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Mantenimiento _$MantenimientoFromJson(Map<String, dynamic> json) {
  return _Mantenimiento.fromJson(json);
}

/// @nodoc
mixin _$Mantenimiento {
  int get id => throw _privateConstructorUsedError;
  int get moto => throw _privateConstructorUsedError;
  String? get motoDetalle => throw _privateConstructorUsedError;
  int? get cliente => throw _privateConstructorUsedError;
  String? get clienteNombre => throw _privateConstructorUsedError;
  String? get clienteCedula => throw _privateConstructorUsedError;
  DateTime get fecha => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  double get costo => throw _privateConstructorUsedError;

  /// Serializes this Mantenimiento to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mantenimiento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MantenimientoCopyWith<Mantenimiento> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MantenimientoCopyWith<$Res> {
  factory $MantenimientoCopyWith(
          Mantenimiento value, $Res Function(Mantenimiento) then) =
      _$MantenimientoCopyWithImpl<$Res, Mantenimiento>;
  @useResult
  $Res call(
      {int id,
      int moto,
      String? motoDetalle,
      int? cliente,
      String? clienteNombre,
      String? clienteCedula,
      DateTime fecha,
      String tipo,
      double costo});
}

/// @nodoc
class _$MantenimientoCopyWithImpl<$Res, $Val extends Mantenimiento>
    implements $MantenimientoCopyWith<$Res> {
  _$MantenimientoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mantenimiento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoDetalle = freezed,
    Object? cliente = freezed,
    Object? clienteNombre = freezed,
    Object? clienteCedula = freezed,
    Object? fecha = null,
    Object? tipo = null,
    Object? costo = null,
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
      motoDetalle: freezed == motoDetalle
          ? _value.motoDetalle
          : motoDetalle // ignore: cast_nullable_to_non_nullable
              as String?,
      cliente: freezed == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int?,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteCedula: freezed == clienteCedula
          ? _value.clienteCedula
          : clienteCedula // ignore: cast_nullable_to_non_nullable
              as String?,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      costo: null == costo
          ? _value.costo
          : costo // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MantenimientoImplCopyWith<$Res>
    implements $MantenimientoCopyWith<$Res> {
  factory _$$MantenimientoImplCopyWith(
          _$MantenimientoImpl value, $Res Function(_$MantenimientoImpl) then) =
      __$$MantenimientoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int moto,
      String? motoDetalle,
      int? cliente,
      String? clienteNombre,
      String? clienteCedula,
      DateTime fecha,
      String tipo,
      double costo});
}

/// @nodoc
class __$$MantenimientoImplCopyWithImpl<$Res>
    extends _$MantenimientoCopyWithImpl<$Res, _$MantenimientoImpl>
    implements _$$MantenimientoImplCopyWith<$Res> {
  __$$MantenimientoImplCopyWithImpl(
      _$MantenimientoImpl _value, $Res Function(_$MantenimientoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mantenimiento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoDetalle = freezed,
    Object? cliente = freezed,
    Object? clienteNombre = freezed,
    Object? clienteCedula = freezed,
    Object? fecha = null,
    Object? tipo = null,
    Object? costo = null,
  }) {
    return _then(_$MantenimientoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      motoDetalle: freezed == motoDetalle
          ? _value.motoDetalle
          : motoDetalle // ignore: cast_nullable_to_non_nullable
              as String?,
      cliente: freezed == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int?,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteCedula: freezed == clienteCedula
          ? _value.clienteCedula
          : clienteCedula // ignore: cast_nullable_to_non_nullable
              as String?,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      costo: null == costo
          ? _value.costo
          : costo // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MantenimientoImpl implements _Mantenimiento {
  const _$MantenimientoImpl(
      {required this.id,
      required this.moto,
      this.motoDetalle,
      this.cliente,
      this.clienteNombre,
      this.clienteCedula,
      required this.fecha,
      required this.tipo,
      required this.costo});

  factory _$MantenimientoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MantenimientoImplFromJson(json);

  @override
  final int id;
  @override
  final int moto;
  @override
  final String? motoDetalle;
  @override
  final int? cliente;
  @override
  final String? clienteNombre;
  @override
  final String? clienteCedula;
  @override
  final DateTime fecha;
  @override
  final String tipo;
  @override
  final double costo;

  @override
  String toString() {
    return 'Mantenimiento(id: $id, moto: $moto, motoDetalle: $motoDetalle, cliente: $cliente, clienteNombre: $clienteNombre, clienteCedula: $clienteCedula, fecha: $fecha, tipo: $tipo, costo: $costo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MantenimientoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.moto, moto) || other.moto == moto) &&
            (identical(other.motoDetalle, motoDetalle) ||
                other.motoDetalle == motoDetalle) &&
            (identical(other.cliente, cliente) || other.cliente == cliente) &&
            (identical(other.clienteNombre, clienteNombre) ||
                other.clienteNombre == clienteNombre) &&
            (identical(other.clienteCedula, clienteCedula) ||
                other.clienteCedula == clienteCedula) &&
            (identical(other.fecha, fecha) || other.fecha == fecha) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.costo, costo) || other.costo == costo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, moto, motoDetalle, cliente,
      clienteNombre, clienteCedula, fecha, tipo, costo);

  /// Create a copy of Mantenimiento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MantenimientoImplCopyWith<_$MantenimientoImpl> get copyWith =>
      __$$MantenimientoImplCopyWithImpl<_$MantenimientoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MantenimientoImplToJson(
      this,
    );
  }
}

abstract class _Mantenimiento implements Mantenimiento {
  const factory _Mantenimiento(
      {required final int id,
      required final int moto,
      final String? motoDetalle,
      final int? cliente,
      final String? clienteNombre,
      final String? clienteCedula,
      required final DateTime fecha,
      required final String tipo,
      required final double costo}) = _$MantenimientoImpl;

  factory _Mantenimiento.fromJson(Map<String, dynamic> json) =
      _$MantenimientoImpl.fromJson;

  @override
  int get id;
  @override
  int get moto;
  @override
  String? get motoDetalle;
  @override
  int? get cliente;
  @override
  String? get clienteNombre;
  @override
  String? get clienteCedula;
  @override
  DateTime get fecha;
  @override
  String get tipo;
  @override
  double get costo;

  /// Create a copy of Mantenimiento
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MantenimientoImplCopyWith<_$MantenimientoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
