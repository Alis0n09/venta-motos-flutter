import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class LoggedUser with _$LoggedUser {
  const factory LoggedUser({
    required int id,
    required String username,
    required String email,
    required bool isStaff,
    String? rol,
  }) = _LoggedUser;

  factory LoggedUser.fromMap(Map<String, dynamic> map) => LoggedUser(
        id: map['user_id'] as int,
        username: map['username'] as String,
        email: map['email'] as String,
        isStaff: map['is_staff'] as bool,
        rol: map['rol'] as String?,
      );

  factory LoggedUser.fromJson(Map<String, dynamic> json) =>
      _$LoggedUserFromJson(json);
}