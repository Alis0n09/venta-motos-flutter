// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direccion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Direccion _$DireccionFromJson(Map<String, dynamic> json) {
  return _Direccion.fromJson(json);
}

/// @nodoc
mixin _$Direccion {
  int get id => throw _privateConstructorUsedError;
  int get cliente => throw _privateConstructorUsedError;
  String get calle => throw _privateConstructorUsedError;
  String get ciudad => throw _privateConstructorUsedError;
  String get provincia => throw _privateConstructorUsedError;
  bool get principal => throw _privateConstructorUsedError;

  /// Serializes this Direccion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DireccionCopyWith<Direccion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DireccionCopyWith<$Res> {
  factory $DireccionCopyWith(Direccion value, $Res Function(Direccion) then) =
      _$DireccionCopyWithImpl<$Res, Direccion>;
  @useResult
  $Res call(
      {int id,
      int cliente,
      String calle,
      String ciudad,
      String provincia,
      bool principal});
}

/// @nodoc
class _$DireccionCopyWithImpl<$Res, $Val extends Direccion>
    implements $DireccionCopyWith<$Res> {
  _$DireccionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cliente = null,
    Object? calle = null,
    Object? ciudad = null,
    Object? provincia = null,
    Object? principal = null,
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
      calle: null == calle
          ? _value.calle
          : calle // ignore: cast_nullable_to_non_nullable
              as String,
      ciudad: null == ciudad
          ? _value.ciudad
          : ciudad // ignore: cast_nullable_to_non_nullable
              as String,
      provincia: null == provincia
          ? _value.provincia
          : provincia // ignore: cast_nullable_to_non_nullable
              as String,
      principal: null == principal
          ? _value.principal
          : principal // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DireccionImplCopyWith<$Res>
    implements $DireccionCopyWith<$Res> {
  factory _$$DireccionImplCopyWith(
          _$DireccionImpl value, $Res Function(_$DireccionImpl) then) =
      __$$DireccionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int cliente,
      String calle,
      String ciudad,
      String provincia,
      bool principal});
}

/// @nodoc
class __$$DireccionImplCopyWithImpl<$Res>
    extends _$DireccionCopyWithImpl<$Res, _$DireccionImpl>
    implements _$$DireccionImplCopyWith<$Res> {
  __$$DireccionImplCopyWithImpl(
      _$DireccionImpl _value, $Res Function(_$DireccionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cliente = null,
    Object? calle = null,
    Object? ciudad = null,
    Object? provincia = null,
    Object? principal = null,
  }) {
    return _then(_$DireccionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cliente: null == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int,
      calle: null == calle
          ? _value.calle
          : calle // ignore: cast_nullable_to_non_nullable
              as String,
      ciudad: null == ciudad
          ? _value.ciudad
          : ciudad // ignore: cast_nullable_to_non_nullable
              as String,
      provincia: null == provincia
          ? _value.provincia
          : provincia // ignore: cast_nullable_to_non_nullable
              as String,
      principal: null == principal
          ? _value.principal
          : principal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DireccionImpl implements _Direccion {
  const _$DireccionImpl(
      {required this.id,
      required this.cliente,
      required this.calle,
      required this.ciudad,
      required this.provincia,
      this.principal = false});

  factory _$DireccionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DireccionImplFromJson(json);

  @override
  final int id;
  @override
  final int cliente;
  @override
  final String calle;
  @override
  final String ciudad;
  @override
  final String provincia;
  @override
  @JsonKey()
  final bool principal;

  @override
  String toString() {
    return 'Direccion(id: $id, cliente: $cliente, calle: $calle, ciudad: $ciudad, provincia: $provincia, principal: $principal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DireccionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cliente, cliente) || other.cliente == cliente) &&
            (identical(other.calle, calle) || other.calle == calle) &&
            (identical(other.ciudad, ciudad) || other.ciudad == ciudad) &&
            (identical(other.provincia, provincia) ||
                other.provincia == provincia) &&
            (identical(other.principal, principal) ||
                other.principal == principal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, cliente, calle, ciudad, provincia, principal);

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DireccionImplCopyWith<_$DireccionImpl> get copyWith =>
      __$$DireccionImplCopyWithImpl<_$DireccionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DireccionImplToJson(
      this,
    );
  }
}

abstract class _Direccion implements Direccion {
  const factory _Direccion(
      {required final int id,
      required final int cliente,
      required final String calle,
      required final String ciudad,
      required final String provincia,
      final bool principal}) = _$DireccionImpl;

  factory _Direccion.fromJson(Map<String, dynamic> json) =
      _$DireccionImpl.fromJson;

  @override
  int get id;
  @override
  int get cliente;
  @override
  String get calle;
  @override
  String get ciudad;
  @override
  String get provincia;
  @override
  bool get principal;

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DireccionImplCopyWith<_$DireccionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
