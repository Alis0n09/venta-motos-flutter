// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoggedUser _$LoggedUserFromJson(Map<String, dynamic> json) {
  return _LoggedUser.fromJson(json);
}

/// @nodoc
mixin _$LoggedUser {
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isStaff => throw _privateConstructorUsedError;
  String? get rol => throw _privateConstructorUsedError;

  /// Serializes this LoggedUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoggedUserCopyWith<LoggedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoggedUserCopyWith<$Res> {
  factory $LoggedUserCopyWith(
          LoggedUser value, $Res Function(LoggedUser) then) =
      _$LoggedUserCopyWithImpl<$Res, LoggedUser>;
  @useResult
  $Res call({int id, String username, String email, bool isStaff, String? rol});
}

/// @nodoc
class _$LoggedUserCopyWithImpl<$Res, $Val extends LoggedUser>
    implements $LoggedUserCopyWith<$Res> {
  _$LoggedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? isStaff = null,
    Object? rol = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isStaff: null == isStaff
          ? _value.isStaff
          : isStaff // ignore: cast_nullable_to_non_nullable
              as bool,
      rol: freezed == rol
          ? _value.rol
          : rol // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoggedUserImplCopyWith<$Res>
    implements $LoggedUserCopyWith<$Res> {
  factory _$$LoggedUserImplCopyWith(
          _$LoggedUserImpl value, $Res Function(_$LoggedUserImpl) then) =
      __$$LoggedUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String username, String email, bool isStaff, String? rol});
}

/// @nodoc
class __$$LoggedUserImplCopyWithImpl<$Res>
    extends _$LoggedUserCopyWithImpl<$Res, _$LoggedUserImpl>
    implements _$$LoggedUserImplCopyWith<$Res> {
  __$$LoggedUserImplCopyWithImpl(
      _$LoggedUserImpl _value, $Res Function(_$LoggedUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? isStaff = null,
    Object? rol = freezed,
  }) {
    return _then(_$LoggedUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isStaff: null == isStaff
          ? _value.isStaff
          : isStaff // ignore: cast_nullable_to_non_nullable
              as bool,
      rol: freezed == rol
          ? _value.rol
          : rol // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoggedUserImpl implements _LoggedUser {
  const _$LoggedUserImpl(
      {required this.id,
      required this.username,
      required this.email,
      required this.isStaff,
      this.rol});

  factory _$LoggedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoggedUserImplFromJson(json);

  @override
  final int id;
  @override
  final String username;
  @override
  final String email;
  @override
  final bool isStaff;
  @override
  final String? rol;

  @override
  String toString() {
    return 'LoggedUser(id: $id, username: $username, email: $email, isStaff: $isStaff, rol: $rol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isStaff, isStaff) || other.isStaff == isStaff) &&
            (identical(other.rol, rol) || other.rol == rol));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, email, isStaff, rol);

  /// Create a copy of LoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedUserImplCopyWith<_$LoggedUserImpl> get copyWith =>
      __$$LoggedUserImplCopyWithImpl<_$LoggedUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoggedUserImplToJson(
      this,
    );
  }
}

abstract class _LoggedUser implements LoggedUser {
  const factory _LoggedUser(
      {required final int id,
      required final String username,
      required final String email,
      required final bool isStaff,
      final String? rol}) = _$LoggedUserImpl;

  factory _LoggedUser.fromJson(Map<String, dynamic> json) =
      _$LoggedUserImpl.fromJson;

  @override
  int get id;
  @override
  String get username;
  @override
  String get email;
  @override
  bool get isStaff;
  @override
  String? get rol;

  /// Create a copy of LoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedUserImplCopyWith<_$LoggedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
