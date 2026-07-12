// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoggedUserImpl _$$LoggedUserImplFromJson(Map<String, dynamic> json) =>
    _$LoggedUserImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      isStaff: json['isStaff'] as bool,
      rol: json['rol'] as String?,
    );

Map<String, dynamic> _$$LoggedUserImplToJson(_$LoggedUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'isStaff': instance.isStaff,
      'rol': instance.rol,
    };
