// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historial_precio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistorialPrecio _$HistorialPrecioFromJson(Map<String, dynamic> json) {
  return _HistorialPrecio.fromJson(json);
}

/// @nodoc
mixin _$HistorialPrecio {
  int get id => throw _privateConstructorUsedError;
  int get moto => throw _privateConstructorUsedError;
  String? get motoNombre => throw _privateConstructorUsedError;
  double get precioAnterior => throw _privateConstructorUsedError;
  double get precioNuevo => throw _privateConstructorUsedError;
  DateTime get fecha => throw _privateConstructorUsedError;
  int? get usuario => throw _privateConstructorUsedError;
  String? get usuarioNombre => throw _privateConstructorUsedError;

  /// Serializes this HistorialPrecio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistorialPrecio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistorialPrecioCopyWith<HistorialPrecio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistorialPrecioCopyWith<$Res> {
  factory $HistorialPrecioCopyWith(
          HistorialPrecio value, $Res Function(HistorialPrecio) then) =
      _$HistorialPrecioCopyWithImpl<$Res, HistorialPrecio>;
  @useResult
  $Res call(
      {int id,
      int moto,
      String? motoNombre,
      double precioAnterior,
      double precioNuevo,
      DateTime fecha,
      int? usuario,
      String? usuarioNombre});
}

/// @nodoc
class _$HistorialPrecioCopyWithImpl<$Res, $Val extends HistorialPrecio>
    implements $HistorialPrecioCopyWith<$Res> {
  _$HistorialPrecioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistorialPrecio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoNombre = freezed,
    Object? precioAnterior = null,
    Object? precioNuevo = null,
    Object? fecha = null,
    Object? usuario = freezed,
    Object? usuarioNombre = freezed,
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
      motoNombre: freezed == motoNombre
          ? _value.motoNombre
          : motoNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      precioAnterior: null == precioAnterior
          ? _value.precioAnterior
          : precioAnterior // ignore: cast_nullable_to_non_nullable
              as double,
      precioNuevo: null == precioNuevo
          ? _value.precioNuevo
          : precioNuevo // ignore: cast_nullable_to_non_nullable
              as double,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
      usuario: freezed == usuario
          ? _value.usuario
          : usuario // ignore: cast_nullable_to_non_nullable
              as int?,
      usuarioNombre: freezed == usuarioNombre
          ? _value.usuarioNombre
          : usuarioNombre // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistorialPrecioImplCopyWith<$Res>
    implements $HistorialPrecioCopyWith<$Res> {
  factory _$$HistorialPrecioImplCopyWith(_$HistorialPrecioImpl value,
          $Res Function(_$HistorialPrecioImpl) then) =
      __$$HistorialPrecioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int moto,
      String? motoNombre,
      double precioAnterior,
      double precioNuevo,
      DateTime fecha,
      int? usuario,
      String? usuarioNombre});
}

/// @nodoc
class __$$HistorialPrecioImplCopyWithImpl<$Res>
    extends _$HistorialPrecioCopyWithImpl<$Res, _$HistorialPrecioImpl>
    implements _$$HistorialPrecioImplCopyWith<$Res> {
  __$$HistorialPrecioImplCopyWithImpl(
      _$HistorialPrecioImpl _value, $Res Function(_$HistorialPrecioImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistorialPrecio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoNombre = freezed,
    Object? precioAnterior = null,
    Object? precioNuevo = null,
    Object? fecha = null,
    Object? usuario = freezed,
    Object? usuarioNombre = freezed,
  }) {
    return _then(_$HistorialPrecioImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      motoNombre: freezed == motoNombre
          ? _value.motoNombre
          : motoNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      precioAnterior: null == precioAnterior
          ? _value.precioAnterior
          : precioAnterior // ignore: cast_nullable_to_non_nullable
              as double,
      precioNuevo: null == precioNuevo
          ? _value.precioNuevo
          : precioNuevo // ignore: cast_nullable_to_non_nullable
              as double,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
      usuario: freezed == usuario
          ? _value.usuario
          : usuario // ignore: cast_nullable_to_non_nullable
              as int?,
      usuarioNombre: freezed == usuarioNombre
          ? _value.usuarioNombre
          : usuarioNombre // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistorialPrecioImpl implements _HistorialPrecio {
  const _$HistorialPrecioImpl(
      {required this.id,
      required this.moto,
      this.motoNombre,
      required this.precioAnterior,
      required this.precioNuevo,
      required this.fecha,
      this.usuario,
      this.usuarioNombre});

  factory _$HistorialPrecioImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistorialPrecioImplFromJson(json);

  @override
  final int id;
  @override
  final int moto;
  @override
  final String? motoNombre;
  @override
  final double precioAnterior;
  @override
  final double precioNuevo;
  @override
  final DateTime fecha;
  @override
  final int? usuario;
  @override
  final String? usuarioNombre;

  @override
  String toString() {
    return 'HistorialPrecio(id: $id, moto: $moto, motoNombre: $motoNombre, precioAnterior: $precioAnterior, precioNuevo: $precioNuevo, fecha: $fecha, usuario: $usuario, usuarioNombre: $usuarioNombre)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistorialPrecioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.moto, moto) || other.moto == moto) &&
            (identical(other.motoNombre, motoNombre) ||
                other.motoNombre == motoNombre) &&
            (identical(other.precioAnterior, precioAnterior) ||
                other.precioAnterior == precioAnterior) &&
            (identical(other.precioNuevo, precioNuevo) ||
                other.precioNuevo == precioNuevo) &&
            (identical(other.fecha, fecha) || other.fecha == fecha) &&
            (identical(other.usuario, usuario) || other.usuario == usuario) &&
            (identical(other.usuarioNombre, usuarioNombre) ||
                other.usuarioNombre == usuarioNombre));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, moto, motoNombre,
      precioAnterior, precioNuevo, fecha, usuario, usuarioNombre);

  /// Create a copy of HistorialPrecio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistorialPrecioImplCopyWith<_$HistorialPrecioImpl> get copyWith =>
      __$$HistorialPrecioImplCopyWithImpl<_$HistorialPrecioImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistorialPrecioImplToJson(
      this,
    );
  }
}

abstract class _HistorialPrecio implements HistorialPrecio {
  const factory _HistorialPrecio(
      {required final int id,
      required final int moto,
      final String? motoNombre,
      required final double precioAnterior,
      required final double precioNuevo,
      required final DateTime fecha,
      final int? usuario,
      final String? usuarioNombre}) = _$HistorialPrecioImpl;

  factory _HistorialPrecio.fromJson(Map<String, dynamic> json) =
      _$HistorialPrecioImpl.fromJson;

  @override
  int get id;
  @override
  int get moto;
  @override
  String? get motoNombre;
  @override
  double get precioAnterior;
  @override
  double get precioNuevo;
  @override
  DateTime get fecha;
  @override
  int? get usuario;
  @override
  String? get usuarioNombre;

  /// Create a copy of HistorialPrecio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistorialPrecioImplCopyWith<_$HistorialPrecioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
