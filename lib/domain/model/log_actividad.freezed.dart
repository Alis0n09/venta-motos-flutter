// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_actividad.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LogActividad _$LogActividadFromJson(Map<String, dynamic> json) {
  return _LogActividad.fromJson(json);
}

/// @nodoc
mixin _$LogActividad {
  int get id => throw _privateConstructorUsedError;
  int? get usuario => throw _privateConstructorUsedError;
  String get accion => throw _privateConstructorUsedError;
  String get entidad => throw _privateConstructorUsedError;
  Map<String, dynamic>? get datosAntes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get datosDespues => throw _privateConstructorUsedError;
  String get fecha => throw _privateConstructorUsedError;

  /// Serializes this LogActividad to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LogActividad
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogActividadCopyWith<LogActividad> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogActividadCopyWith<$Res> {
  factory $LogActividadCopyWith(
          LogActividad value, $Res Function(LogActividad) then) =
      _$LogActividadCopyWithImpl<$Res, LogActividad>;
  @useResult
  $Res call(
      {int id,
      int? usuario,
      String accion,
      String entidad,
      Map<String, dynamic>? datosAntes,
      Map<String, dynamic>? datosDespues,
      String fecha});
}

/// @nodoc
class _$LogActividadCopyWithImpl<$Res, $Val extends LogActividad>
    implements $LogActividadCopyWith<$Res> {
  _$LogActividadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogActividad
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? usuario = freezed,
    Object? accion = null,
    Object? entidad = null,
    Object? datosAntes = freezed,
    Object? datosDespues = freezed,
    Object? fecha = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      usuario: freezed == usuario
          ? _value.usuario
          : usuario // ignore: cast_nullable_to_non_nullable
              as int?,
      accion: null == accion
          ? _value.accion
          : accion // ignore: cast_nullable_to_non_nullable
              as String,
      entidad: null == entidad
          ? _value.entidad
          : entidad // ignore: cast_nullable_to_non_nullable
              as String,
      datosAntes: freezed == datosAntes
          ? _value.datosAntes
          : datosAntes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      datosDespues: freezed == datosDespues
          ? _value.datosDespues
          : datosDespues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogActividadImplCopyWith<$Res>
    implements $LogActividadCopyWith<$Res> {
  factory _$$LogActividadImplCopyWith(
          _$LogActividadImpl value, $Res Function(_$LogActividadImpl) then) =
      __$$LogActividadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? usuario,
      String accion,
      String entidad,
      Map<String, dynamic>? datosAntes,
      Map<String, dynamic>? datosDespues,
      String fecha});
}

/// @nodoc
class __$$LogActividadImplCopyWithImpl<$Res>
    extends _$LogActividadCopyWithImpl<$Res, _$LogActividadImpl>
    implements _$$LogActividadImplCopyWith<$Res> {
  __$$LogActividadImplCopyWithImpl(
      _$LogActividadImpl _value, $Res Function(_$LogActividadImpl) _then)
      : super(_value, _then);

  /// Create a copy of LogActividad
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? usuario = freezed,
    Object? accion = null,
    Object? entidad = null,
    Object? datosAntes = freezed,
    Object? datosDespues = freezed,
    Object? fecha = null,
  }) {
    return _then(_$LogActividadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      usuario: freezed == usuario
          ? _value.usuario
          : usuario // ignore: cast_nullable_to_non_nullable
              as int?,
      accion: null == accion
          ? _value.accion
          : accion // ignore: cast_nullable_to_non_nullable
              as String,
      entidad: null == entidad
          ? _value.entidad
          : entidad // ignore: cast_nullable_to_non_nullable
              as String,
      datosAntes: freezed == datosAntes
          ? _value._datosAntes
          : datosAntes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      datosDespues: freezed == datosDespues
          ? _value._datosDespues
          : datosDespues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogActividadImpl implements _LogActividad {
  const _$LogActividadImpl(
      {required this.id,
      this.usuario,
      required this.accion,
      required this.entidad,
      final Map<String, dynamic>? datosAntes,
      final Map<String, dynamic>? datosDespues,
      required this.fecha})
      : _datosAntes = datosAntes,
        _datosDespues = datosDespues;

  factory _$LogActividadImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogActividadImplFromJson(json);

  @override
  final int id;
  @override
  final int? usuario;
  @override
  final String accion;
  @override
  final String entidad;
  final Map<String, dynamic>? _datosAntes;
  @override
  Map<String, dynamic>? get datosAntes {
    final value = _datosAntes;
    if (value == null) return null;
    if (_datosAntes is EqualUnmodifiableMapView) return _datosAntes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _datosDespues;
  @override
  Map<String, dynamic>? get datosDespues {
    final value = _datosDespues;
    if (value == null) return null;
    if (_datosDespues is EqualUnmodifiableMapView) return _datosDespues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String fecha;

  @override
  String toString() {
    return 'LogActividad(id: $id, usuario: $usuario, accion: $accion, entidad: $entidad, datosAntes: $datosAntes, datosDespues: $datosDespues, fecha: $fecha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogActividadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.usuario, usuario) || other.usuario == usuario) &&
            (identical(other.accion, accion) || other.accion == accion) &&
            (identical(other.entidad, entidad) || other.entidad == entidad) &&
            const DeepCollectionEquality()
                .equals(other._datosAntes, _datosAntes) &&
            const DeepCollectionEquality()
                .equals(other._datosDespues, _datosDespues) &&
            (identical(other.fecha, fecha) || other.fecha == fecha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      usuario,
      accion,
      entidad,
      const DeepCollectionEquality().hash(_datosAntes),
      const DeepCollectionEquality().hash(_datosDespues),
      fecha);

  /// Create a copy of LogActividad
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogActividadImplCopyWith<_$LogActividadImpl> get copyWith =>
      __$$LogActividadImplCopyWithImpl<_$LogActividadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogActividadImplToJson(
      this,
    );
  }
}

abstract class _LogActividad implements LogActividad {
  const factory _LogActividad(
      {required final int id,
      final int? usuario,
      required final String accion,
      required final String entidad,
      final Map<String, dynamic>? datosAntes,
      final Map<String, dynamic>? datosDespues,
      required final String fecha}) = _$LogActividadImpl;

  factory _LogActividad.fromJson(Map<String, dynamic> json) =
      _$LogActividadImpl.fromJson;

  @override
  int get id;
  @override
  int? get usuario;
  @override
  String get accion;
  @override
  String get entidad;
  @override
  Map<String, dynamic>? get datosAntes;
  @override
  Map<String, dynamic>? get datosDespues;
  @override
  String get fecha;

  /// Create a copy of LogActividad
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogActividadImplCopyWith<_$LogActividadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
