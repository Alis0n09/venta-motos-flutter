// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'perfil.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PerfilCuenta _$PerfilCuentaFromJson(Map<String, dynamic> json) {
  return _PerfilCuenta.fromJson(json);
}

/// @nodoc
mixin _$PerfilCuenta {
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;

  /// Serializes this PerfilCuenta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerfilCuenta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerfilCuentaCopyWith<PerfilCuenta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerfilCuentaCopyWith<$Res> {
  factory $PerfilCuentaCopyWith(
          PerfilCuenta value, $Res Function(PerfilCuenta) then) =
      _$PerfilCuentaCopyWithImpl<$Res, PerfilCuenta>;
  @useResult
  $Res call(
      {String username, String email, String? firstName, String? lastName});
}

/// @nodoc
class _$PerfilCuentaCopyWithImpl<$Res, $Val extends PerfilCuenta>
    implements $PerfilCuentaCopyWith<$Res> {
  _$PerfilCuentaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerfilCuenta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerfilCuentaImplCopyWith<$Res>
    implements $PerfilCuentaCopyWith<$Res> {
  factory _$$PerfilCuentaImplCopyWith(
          _$PerfilCuentaImpl value, $Res Function(_$PerfilCuentaImpl) then) =
      __$$PerfilCuentaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username, String email, String? firstName, String? lastName});
}

/// @nodoc
class __$$PerfilCuentaImplCopyWithImpl<$Res>
    extends _$PerfilCuentaCopyWithImpl<$Res, _$PerfilCuentaImpl>
    implements _$$PerfilCuentaImplCopyWith<$Res> {
  __$$PerfilCuentaImplCopyWithImpl(
      _$PerfilCuentaImpl _value, $Res Function(_$PerfilCuentaImpl) _then)
      : super(_value, _then);

  /// Create a copy of PerfilCuenta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(_$PerfilCuentaImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerfilCuentaImpl implements _PerfilCuenta {
  const _$PerfilCuentaImpl(
      {required this.username,
      required this.email,
      this.firstName,
      this.lastName});

  factory _$PerfilCuentaImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerfilCuentaImplFromJson(json);

  @override
  final String username;
  @override
  final String email;
  @override
  final String? firstName;
  @override
  final String? lastName;

  @override
  String toString() {
    return 'PerfilCuenta(username: $username, email: $email, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerfilCuentaImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, username, email, firstName, lastName);

  /// Create a copy of PerfilCuenta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerfilCuentaImplCopyWith<_$PerfilCuentaImpl> get copyWith =>
      __$$PerfilCuentaImplCopyWithImpl<_$PerfilCuentaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerfilCuentaImplToJson(
      this,
    );
  }
}

abstract class _PerfilCuenta implements PerfilCuenta {
  const factory _PerfilCuenta(
      {required final String username,
      required final String email,
      final String? firstName,
      final String? lastName}) = _$PerfilCuentaImpl;

  factory _PerfilCuenta.fromJson(Map<String, dynamic> json) =
      _$PerfilCuentaImpl.fromJson;

  @override
  String get username;
  @override
  String get email;
  @override
  String? get firstName;
  @override
  String? get lastName;

  /// Create a copy of PerfilCuenta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerfilCuentaImplCopyWith<_$PerfilCuentaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerfilCliente _$PerfilClienteFromJson(Map<String, dynamic> json) {
  return _PerfilCliente.fromJson(json);
}

/// @nodoc
mixin _$PerfilCliente {
  String get nombre => throw _privateConstructorUsedError;
  String get apellido => throw _privateConstructorUsedError;
  String get cedula => throw _privateConstructorUsedError;
  String? get telefono => throw _privateConstructorUsedError;
  String? get direccion => throw _privateConstructorUsedError;

  /// Serializes this PerfilCliente to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerfilCliente
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerfilClienteCopyWith<PerfilCliente> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerfilClienteCopyWith<$Res> {
  factory $PerfilClienteCopyWith(
          PerfilCliente value, $Res Function(PerfilCliente) then) =
      _$PerfilClienteCopyWithImpl<$Res, PerfilCliente>;
  @useResult
  $Res call(
      {String nombre,
      String apellido,
      String cedula,
      String? telefono,
      String? direccion});
}

/// @nodoc
class _$PerfilClienteCopyWithImpl<$Res, $Val extends PerfilCliente>
    implements $PerfilClienteCopyWith<$Res> {
  _$PerfilClienteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerfilCliente
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? apellido = null,
    Object? cedula = null,
    Object? telefono = freezed,
    Object? direccion = freezed,
  }) {
    return _then(_value.copyWith(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      apellido: null == apellido
          ? _value.apellido
          : apellido // ignore: cast_nullable_to_non_nullable
              as String,
      cedula: null == cedula
          ? _value.cedula
          : cedula // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String?,
      direccion: freezed == direccion
          ? _value.direccion
          : direccion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerfilClienteImplCopyWith<$Res>
    implements $PerfilClienteCopyWith<$Res> {
  factory _$$PerfilClienteImplCopyWith(
          _$PerfilClienteImpl value, $Res Function(_$PerfilClienteImpl) then) =
      __$$PerfilClienteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nombre,
      String apellido,
      String cedula,
      String? telefono,
      String? direccion});
}

/// @nodoc
class __$$PerfilClienteImplCopyWithImpl<$Res>
    extends _$PerfilClienteCopyWithImpl<$Res, _$PerfilClienteImpl>
    implements _$$PerfilClienteImplCopyWith<$Res> {
  __$$PerfilClienteImplCopyWithImpl(
      _$PerfilClienteImpl _value, $Res Function(_$PerfilClienteImpl) _then)
      : super(_value, _then);

  /// Create a copy of PerfilCliente
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? apellido = null,
    Object? cedula = null,
    Object? telefono = freezed,
    Object? direccion = freezed,
  }) {
    return _then(_$PerfilClienteImpl(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      apellido: null == apellido
          ? _value.apellido
          : apellido // ignore: cast_nullable_to_non_nullable
              as String,
      cedula: null == cedula
          ? _value.cedula
          : cedula // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: freezed == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String?,
      direccion: freezed == direccion
          ? _value.direccion
          : direccion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerfilClienteImpl implements _PerfilCliente {
  const _$PerfilClienteImpl(
      {required this.nombre,
      required this.apellido,
      required this.cedula,
      this.telefono,
      this.direccion});

  factory _$PerfilClienteImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerfilClienteImplFromJson(json);

  @override
  final String nombre;
  @override
  final String apellido;
  @override
  final String cedula;
  @override
  final String? telefono;
  @override
  final String? direccion;

  @override
  String toString() {
    return 'PerfilCliente(nombre: $nombre, apellido: $apellido, cedula: $cedula, telefono: $telefono, direccion: $direccion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerfilClienteImpl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.apellido, apellido) ||
                other.apellido == apellido) &&
            (identical(other.cedula, cedula) || other.cedula == cedula) &&
            (identical(other.telefono, telefono) ||
                other.telefono == telefono) &&
            (identical(other.direccion, direccion) ||
                other.direccion == direccion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nombre, apellido, cedula, telefono, direccion);

  /// Create a copy of PerfilCliente
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerfilClienteImplCopyWith<_$PerfilClienteImpl> get copyWith =>
      __$$PerfilClienteImplCopyWithImpl<_$PerfilClienteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerfilClienteImplToJson(
      this,
    );
  }
}

abstract class _PerfilCliente implements PerfilCliente {
  const factory _PerfilCliente(
      {required final String nombre,
      required final String apellido,
      required final String cedula,
      final String? telefono,
      final String? direccion}) = _$PerfilClienteImpl;

  factory _PerfilCliente.fromJson(Map<String, dynamic> json) =
      _$PerfilClienteImpl.fromJson;

  @override
  String get nombre;
  @override
  String get apellido;
  @override
  String get cedula;
  @override
  String? get telefono;
  @override
  String? get direccion;

  /// Create a copy of PerfilCliente
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerfilClienteImplCopyWith<_$PerfilClienteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
