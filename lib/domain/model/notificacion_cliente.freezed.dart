// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notificacion_cliente.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificacionCliente _$NotificacionClienteFromJson(Map<String, dynamic> json) {
  return _NotificacionCliente.fromJson(json);
}

/// @nodoc
mixin _$NotificacionCliente {
  int get id => throw _privateConstructorUsedError;
  int get cliente => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  String get mensaje => throw _privateConstructorUsedError;
  bool get leido => throw _privateConstructorUsedError;
  DateTime get fecha => throw _privateConstructorUsedError;

  /// Serializes this NotificacionCliente to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificacionCliente
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificacionClienteCopyWith<NotificacionCliente> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificacionClienteCopyWith<$Res> {
  factory $NotificacionClienteCopyWith(
          NotificacionCliente value, $Res Function(NotificacionCliente) then) =
      _$NotificacionClienteCopyWithImpl<$Res, NotificacionCliente>;
  @useResult
  $Res call(
      {int id,
      int cliente,
      String tipo,
      String mensaje,
      bool leido,
      DateTime fecha});
}

/// @nodoc
class _$NotificacionClienteCopyWithImpl<$Res, $Val extends NotificacionCliente>
    implements $NotificacionClienteCopyWith<$Res> {
  _$NotificacionClienteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificacionCliente
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cliente = null,
    Object? tipo = null,
    Object? mensaje = null,
    Object? leido = null,
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
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      mensaje: null == mensaje
          ? _value.mensaje
          : mensaje // ignore: cast_nullable_to_non_nullable
              as String,
      leido: null == leido
          ? _value.leido
          : leido // ignore: cast_nullable_to_non_nullable
              as bool,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificacionClienteImplCopyWith<$Res>
    implements $NotificacionClienteCopyWith<$Res> {
  factory _$$NotificacionClienteImplCopyWith(_$NotificacionClienteImpl value,
          $Res Function(_$NotificacionClienteImpl) then) =
      __$$NotificacionClienteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int cliente,
      String tipo,
      String mensaje,
      bool leido,
      DateTime fecha});
}

/// @nodoc
class __$$NotificacionClienteImplCopyWithImpl<$Res>
    extends _$NotificacionClienteCopyWithImpl<$Res, _$NotificacionClienteImpl>
    implements _$$NotificacionClienteImplCopyWith<$Res> {
  __$$NotificacionClienteImplCopyWithImpl(_$NotificacionClienteImpl _value,
      $Res Function(_$NotificacionClienteImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificacionCliente
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cliente = null,
    Object? tipo = null,
    Object? mensaje = null,
    Object? leido = null,
    Object? fecha = null,
  }) {
    return _then(_$NotificacionClienteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cliente: null == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      mensaje: null == mensaje
          ? _value.mensaje
          : mensaje // ignore: cast_nullable_to_non_nullable
              as String,
      leido: null == leido
          ? _value.leido
          : leido // ignore: cast_nullable_to_non_nullable
              as bool,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificacionClienteImpl implements _NotificacionCliente {
  const _$NotificacionClienteImpl(
      {required this.id,
      required this.cliente,
      required this.tipo,
      required this.mensaje,
      required this.leido,
      required this.fecha});

  factory _$NotificacionClienteImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificacionClienteImplFromJson(json);

  @override
  final int id;
  @override
  final int cliente;
  @override
  final String tipo;
  @override
  final String mensaje;
  @override
  final bool leido;
  @override
  final DateTime fecha;

  @override
  String toString() {
    return 'NotificacionCliente(id: $id, cliente: $cliente, tipo: $tipo, mensaje: $mensaje, leido: $leido, fecha: $fecha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificacionClienteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cliente, cliente) || other.cliente == cliente) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.mensaje, mensaje) || other.mensaje == mensaje) &&
            (identical(other.leido, leido) || other.leido == leido) &&
            (identical(other.fecha, fecha) || other.fecha == fecha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, cliente, tipo, mensaje, leido, fecha);

  /// Create a copy of NotificacionCliente
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificacionClienteImplCopyWith<_$NotificacionClienteImpl> get copyWith =>
      __$$NotificacionClienteImplCopyWithImpl<_$NotificacionClienteImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificacionClienteImplToJson(
      this,
    );
  }
}

abstract class _NotificacionCliente implements NotificacionCliente {
  const factory _NotificacionCliente(
      {required final int id,
      required final int cliente,
      required final String tipo,
      required final String mensaje,
      required final bool leido,
      required final DateTime fecha}) = _$NotificacionClienteImpl;

  factory _NotificacionCliente.fromJson(Map<String, dynamic> json) =
      _$NotificacionClienteImpl.fromJson;

  @override
  int get id;
  @override
  int get cliente;
  @override
  String get tipo;
  @override
  String get mensaje;
  @override
  bool get leido;
  @override
  DateTime get fecha;

  /// Create a copy of NotificacionCliente
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificacionClienteImplCopyWith<_$NotificacionClienteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
