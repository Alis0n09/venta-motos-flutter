// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garantia.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Garantia _$GarantiaFromJson(Map<String, dynamic> json) {
  return _Garantia.fromJson(json);
}

/// @nodoc
mixin _$Garantia {
  int get id => throw _privateConstructorUsedError;
  int get venta => throw _privateConstructorUsedError;
  DateTime get fechaInicio => throw _privateConstructorUsedError;
  DateTime get fechaFin => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;

  /// Serializes this Garantia to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Garantia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GarantiaCopyWith<Garantia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GarantiaCopyWith<$Res> {
  factory $GarantiaCopyWith(Garantia value, $Res Function(Garantia) then) =
      _$GarantiaCopyWithImpl<$Res, Garantia>;
  @useResult
  $Res call(
      {int id,
      int venta,
      DateTime fechaInicio,
      DateTime fechaFin,
      String tipo});
}

/// @nodoc
class _$GarantiaCopyWithImpl<$Res, $Val extends Garantia>
    implements $GarantiaCopyWith<$Res> {
  _$GarantiaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Garantia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? venta = null,
    Object? fechaInicio = null,
    Object? fechaFin = null,
    Object? tipo = null,
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
      fechaInicio: null == fechaInicio
          ? _value.fechaInicio
          : fechaInicio // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFin: null == fechaFin
          ? _value.fechaFin
          : fechaFin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GarantiaImplCopyWith<$Res>
    implements $GarantiaCopyWith<$Res> {
  factory _$$GarantiaImplCopyWith(
          _$GarantiaImpl value, $Res Function(_$GarantiaImpl) then) =
      __$$GarantiaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int venta,
      DateTime fechaInicio,
      DateTime fechaFin,
      String tipo});
}

/// @nodoc
class __$$GarantiaImplCopyWithImpl<$Res>
    extends _$GarantiaCopyWithImpl<$Res, _$GarantiaImpl>
    implements _$$GarantiaImplCopyWith<$Res> {
  __$$GarantiaImplCopyWithImpl(
      _$GarantiaImpl _value, $Res Function(_$GarantiaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Garantia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? venta = null,
    Object? fechaInicio = null,
    Object? fechaFin = null,
    Object? tipo = null,
  }) {
    return _then(_$GarantiaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      venta: null == venta
          ? _value.venta
          : venta // ignore: cast_nullable_to_non_nullable
              as int,
      fechaInicio: null == fechaInicio
          ? _value.fechaInicio
          : fechaInicio // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFin: null == fechaFin
          ? _value.fechaFin
          : fechaFin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GarantiaImpl implements _Garantia {
  const _$GarantiaImpl(
      {required this.id,
      required this.venta,
      required this.fechaInicio,
      required this.fechaFin,
      required this.tipo});

  factory _$GarantiaImpl.fromJson(Map<String, dynamic> json) =>
      _$$GarantiaImplFromJson(json);

  @override
  final int id;
  @override
  final int venta;
  @override
  final DateTime fechaInicio;
  @override
  final DateTime fechaFin;
  @override
  final String tipo;

  @override
  String toString() {
    return 'Garantia(id: $id, venta: $venta, fechaInicio: $fechaInicio, fechaFin: $fechaFin, tipo: $tipo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GarantiaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.venta, venta) || other.venta == venta) &&
            (identical(other.fechaInicio, fechaInicio) ||
                other.fechaInicio == fechaInicio) &&
            (identical(other.fechaFin, fechaFin) ||
                other.fechaFin == fechaFin) &&
            (identical(other.tipo, tipo) || other.tipo == tipo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, venta, fechaInicio, fechaFin, tipo);

  /// Create a copy of Garantia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GarantiaImplCopyWith<_$GarantiaImpl> get copyWith =>
      __$$GarantiaImplCopyWithImpl<_$GarantiaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GarantiaImplToJson(
      this,
    );
  }
}

abstract class _Garantia implements Garantia {
  const factory _Garantia(
      {required final int id,
      required final int venta,
      required final DateTime fechaInicio,
      required final DateTime fechaFin,
      required final String tipo}) = _$GarantiaImpl;

  factory _Garantia.fromJson(Map<String, dynamic> json) =
      _$GarantiaImpl.fromJson;

  @override
  int get id;
  @override
  int get venta;
  @override
  DateTime get fechaInicio;
  @override
  DateTime get fechaFin;
  @override
  String get tipo;

  /// Create a copy of Garantia
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GarantiaImplCopyWith<_$GarantiaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
