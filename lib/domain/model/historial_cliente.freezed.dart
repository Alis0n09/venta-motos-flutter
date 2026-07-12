// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historial_cliente.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistorialCliente _$HistorialClienteFromJson(Map<String, dynamic> json) {
  return _HistorialCliente.fromJson(json);
}

/// @nodoc
mixin _$HistorialCliente {
  int get id => throw _privateConstructorUsedError;
  int get cliente => throw _privateConstructorUsedError;
  String? get clienteNombre => throw _privateConstructorUsedError;
  String? get clienteCedula => throw _privateConstructorUsedError;
  String get tipoEvento => throw _privateConstructorUsedError;
  Map<String, dynamic> get detalle => throw _privateConstructorUsedError;
  DateTime get fecha => throw _privateConstructorUsedError;

  /// Serializes this HistorialCliente to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistorialCliente
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistorialClienteCopyWith<HistorialCliente> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistorialClienteCopyWith<$Res> {
  factory $HistorialClienteCopyWith(
          HistorialCliente value, $Res Function(HistorialCliente) then) =
      _$HistorialClienteCopyWithImpl<$Res, HistorialCliente>;
  @useResult
  $Res call(
      {int id,
      int cliente,
      String? clienteNombre,
      String? clienteCedula,
      String tipoEvento,
      Map<String, dynamic> detalle,
      DateTime fecha});
}

/// @nodoc
class _$HistorialClienteCopyWithImpl<$Res, $Val extends HistorialCliente>
    implements $HistorialClienteCopyWith<$Res> {
  _$HistorialClienteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistorialCliente
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cliente = null,
    Object? clienteNombre = freezed,
    Object? clienteCedula = freezed,
    Object? tipoEvento = null,
    Object? detalle = null,
    Object? fecha = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cliente: null == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteCedula: freezed == clienteCedula
          ? _value.clienteCedula
          : clienteCedula // ignore: cast_nullable_to_non_nullable
              as String?,
      tipoEvento: null == tipoEvento
          ? _value.tipoEvento
          : tipoEvento // ignore: cast_nullable_to_non_nullable
              as String,
      detalle: null == detalle
          ? _value.detalle
          : detalle // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistorialClienteImplCopyWith<$Res>
    implements $HistorialClienteCopyWith<$Res> {
  factory _$$HistorialClienteImplCopyWith(_$HistorialClienteImpl value,
          $Res Function(_$HistorialClienteImpl) then) =
      __$$HistorialClienteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int cliente,
      String? clienteNombre,
      String? clienteCedula,
      String tipoEvento,
      Map<String, dynamic> detalle,
      DateTime fecha});
}

/// @nodoc
class __$$HistorialClienteImplCopyWithImpl<$Res>
    extends _$HistorialClienteCopyWithImpl<$Res, _$HistorialClienteImpl>
    implements _$$HistorialClienteImplCopyWith<$Res> {
  __$$HistorialClienteImplCopyWithImpl(_$HistorialClienteImpl _value,
      $Res Function(_$HistorialClienteImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistorialCliente
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cliente = null,
    Object? clienteNombre = freezed,
    Object? clienteCedula = freezed,
    Object? tipoEvento = null,
    Object? detalle = null,
    Object? fecha = null,
  }) {
    return _then(_$HistorialClienteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cliente: null == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clienteCedula: freezed == clienteCedula
          ? _value.clienteCedula
          : clienteCedula // ignore: cast_nullable_to_non_nullable
              as String?,
      tipoEvento: null == tipoEvento
          ? _value.tipoEvento
          : tipoEvento // ignore: cast_nullable_to_non_nullable
              as String,
      detalle: null == detalle
          ? _value._detalle
          : detalle // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistorialClienteImpl implements _HistorialCliente {
  const _$HistorialClienteImpl(
      {required this.id,
      required this.cliente,
      this.clienteNombre,
      this.clienteCedula,
      required this.tipoEvento,
      final Map<String, dynamic> detalle = const <String, dynamic>{},
      required this.fecha})
      : _detalle = detalle;

  factory _$HistorialClienteImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistorialClienteImplFromJson(json);

  @override
  final int id;
  @override
  final int cliente;
  @override
  final String? clienteNombre;
  @override
  final String? clienteCedula;
  @override
  final String tipoEvento;
  final Map<String, dynamic> _detalle;
  @override
  @JsonKey()
  Map<String, dynamic> get detalle {
    if (_detalle is EqualUnmodifiableMapView) return _detalle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_detalle);
  }

  @override
  final DateTime fecha;

  @override
  String toString() {
    return 'HistorialCliente(id: $id, cliente: $cliente, clienteNombre: $clienteNombre, clienteCedula: $clienteCedula, tipoEvento: $tipoEvento, detalle: $detalle, fecha: $fecha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistorialClienteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cliente, cliente) || other.cliente == cliente) &&
            (identical(other.clienteNombre, clienteNombre) ||
                other.clienteNombre == clienteNombre) &&
            (identical(other.clienteCedula, clienteCedula) ||
                other.clienteCedula == clienteCedula) &&
            (identical(other.tipoEvento, tipoEvento) ||
                other.tipoEvento == tipoEvento) &&
            const DeepCollectionEquality().equals(other._detalle, _detalle) &&
            (identical(other.fecha, fecha) || other.fecha == fecha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      cliente,
      clienteNombre,
      clienteCedula,
      tipoEvento,
      const DeepCollectionEquality().hash(_detalle),
      fecha);

  /// Create a copy of HistorialCliente
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistorialClienteImplCopyWith<_$HistorialClienteImpl> get copyWith =>
      __$$HistorialClienteImplCopyWithImpl<_$HistorialClienteImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistorialClienteImplToJson(
      this,
    );
  }
}

abstract class _HistorialCliente implements HistorialCliente {
  const factory _HistorialCliente(
      {required final int id,
      required final int cliente,
      final String? clienteNombre,
      final String? clienteCedula,
      required final String tipoEvento,
      final Map<String, dynamic> detalle,
      required final DateTime fecha}) = _$HistorialClienteImpl;

  factory _HistorialCliente.fromJson(Map<String, dynamic> json) =
      _$HistorialClienteImpl.fromJson;

  @override
  int get id;
  @override
  int get cliente;
  @override
  String? get clienteNombre;
  @override
  String? get clienteCedula;
  @override
  String get tipoEvento;
  @override
  Map<String, dynamic> get detalle;
  @override
  DateTime get fecha;

  /// Create a copy of HistorialCliente
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistorialClienteImplCopyWith<_$HistorialClienteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
