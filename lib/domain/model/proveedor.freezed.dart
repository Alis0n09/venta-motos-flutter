// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proveedor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Proveedor _$ProveedorFromJson(Map<String, dynamic> json) {
  return _Proveedor.fromJson(json);
}

/// @nodoc
mixin _$Proveedor {
  int get id => throw _privateConstructorUsedError;
  String get empresa => throw _privateConstructorUsedError;
  String? get contacto => throw _privateConstructorUsedError;
  String? get correo => throw _privateConstructorUsedError;
  String? get pais => throw _privateConstructorUsedError;

  /// Serializes this Proveedor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Proveedor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProveedorCopyWith<Proveedor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProveedorCopyWith<$Res> {
  factory $ProveedorCopyWith(Proveedor value, $Res Function(Proveedor) then) =
      _$ProveedorCopyWithImpl<$Res, Proveedor>;
  @useResult
  $Res call(
      {int id, String empresa, String? contacto, String? correo, String? pais});
}

/// @nodoc
class _$ProveedorCopyWithImpl<$Res, $Val extends Proveedor>
    implements $ProveedorCopyWith<$Res> {
  _$ProveedorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Proveedor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? empresa = null,
    Object? contacto = freezed,
    Object? correo = freezed,
    Object? pais = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      empresa: null == empresa
          ? _value.empresa
          : empresa // ignore: cast_nullable_to_non_nullable
              as String,
      contacto: freezed == contacto
          ? _value.contacto
          : contacto // ignore: cast_nullable_to_non_nullable
              as String?,
      correo: freezed == correo
          ? _value.correo
          : correo // ignore: cast_nullable_to_non_nullable
              as String?,
      pais: freezed == pais
          ? _value.pais
          : pais // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProveedorImplCopyWith<$Res>
    implements $ProveedorCopyWith<$Res> {
  factory _$$ProveedorImplCopyWith(
          _$ProveedorImpl value, $Res Function(_$ProveedorImpl) then) =
      __$$ProveedorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String empresa, String? contacto, String? correo, String? pais});
}

/// @nodoc
class __$$ProveedorImplCopyWithImpl<$Res>
    extends _$ProveedorCopyWithImpl<$Res, _$ProveedorImpl>
    implements _$$ProveedorImplCopyWith<$Res> {
  __$$ProveedorImplCopyWithImpl(
      _$ProveedorImpl _value, $Res Function(_$ProveedorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Proveedor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? empresa = null,
    Object? contacto = freezed,
    Object? correo = freezed,
    Object? pais = freezed,
  }) {
    return _then(_$ProveedorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      empresa: null == empresa
          ? _value.empresa
          : empresa // ignore: cast_nullable_to_non_nullable
              as String,
      contacto: freezed == contacto
          ? _value.contacto
          : contacto // ignore: cast_nullable_to_non_nullable
              as String?,
      correo: freezed == correo
          ? _value.correo
          : correo // ignore: cast_nullable_to_non_nullable
              as String?,
      pais: freezed == pais
          ? _value.pais
          : pais // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProveedorImpl implements _Proveedor {
  const _$ProveedorImpl(
      {required this.id,
      required this.empresa,
      this.contacto,
      this.correo,
      this.pais});

  factory _$ProveedorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProveedorImplFromJson(json);

  @override
  final int id;
  @override
  final String empresa;
  @override
  final String? contacto;
  @override
  final String? correo;
  @override
  final String? pais;

  @override
  String toString() {
    return 'Proveedor(id: $id, empresa: $empresa, contacto: $contacto, correo: $correo, pais: $pais)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProveedorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.empresa, empresa) || other.empresa == empresa) &&
            (identical(other.contacto, contacto) ||
                other.contacto == contacto) &&
            (identical(other.correo, correo) || other.correo == correo) &&
            (identical(other.pais, pais) || other.pais == pais));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, empresa, contacto, correo, pais);

  /// Create a copy of Proveedor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProveedorImplCopyWith<_$ProveedorImpl> get copyWith =>
      __$$ProveedorImplCopyWithImpl<_$ProveedorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProveedorImplToJson(
      this,
    );
  }
}

abstract class _Proveedor implements Proveedor {
  const factory _Proveedor(
      {required final int id,
      required final String empresa,
      final String? contacto,
      final String? correo,
      final String? pais}) = _$ProveedorImpl;

  factory _Proveedor.fromJson(Map<String, dynamic> json) =
      _$ProveedorImpl.fromJson;

  @override
  int get id;
  @override
  String get empresa;
  @override
  String? get contacto;
  @override
  String? get correo;
  @override
  String? get pais;

  /// Create a copy of Proveedor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProveedorImplCopyWith<_$ProveedorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
