// lib/data/remote/api/auth_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import 'dio_client.dart';
import '../../local/secure_storage.dart';
import '../../../domain/model/auth_models.dart';

abstract class AuthRemoteDatasource {
  Future<LoggedUser> login(String username, String password);
  Future<LoggedUser> register({
    required String username,
    required String email,
    required String password,
    required String password2,
    required String nombre,
    required String apellido,
    required String cedula,
    String? telefono,
  });
  Future<void> logout();
  Future<void> solicitarResetPassword(String username);
  Future<void> confirmarResetPassword({
    required String codigo,
    required String newPassword,
    required String newPassword2,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio _dio;
  final SecureStorage _storage;

  AuthRemoteDatasourceImpl(this._dio, this._storage);

  @override
  Future<LoggedUser> login(String username, String password) async {
    try {
      final res = await _dio.post(
        '/auth/login/',
        data: {'username': username, 'password': password},
      );
      final data = res.data as Map<String, dynamic>;
      await _storage.saveTokens(data['access'] as String, data['refresh'] as String);
      await _storage.saveUser(
        id: data['user_id'] as int,
        username: data['username'] as String,
        email: data['email'] as String,
        isStaff: data['is_staff'] as bool,
        rol: data['rol'] as String?,
      );
      return LoggedUser.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<LoggedUser> register({
    required String username,
    required String email,
    required String password,
    required String password2,
    required String nombre,
    required String apellido,
    required String cedula,
    String? telefono,
  }) async {
    try {
      final res = await _dio.post(
        '/auth/register/',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'password2': password2,
          'nombre': nombre,
          'apellido': apellido,
          'cedula': cedula,
          if (telefono != null && telefono.isNotEmpty) 'telefono': telefono,
        },
      );
      final data = res.data as Map<String, dynamic>;
      await _storage.saveTokens(data['access'] as String, data['refresh'] as String);
      await _storage.saveUser(
        id: data['user_id'] as int,
        username: data['username'] as String,
        email: data['email'] as String,
        isStaff: data['is_staff'] as bool,
        rol: null,
      );
      return LoggedUser.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refresh = await _storage.getRefresh();
      if (refresh != null && refresh.isNotEmpty) {
        await _dio.post('/auth/logout/', data: {'refresh': refresh});
      }
    } catch (_) {
    } finally {
      await _storage.clearSession();
    }
  }

  @override
  Future<void> solicitarResetPassword(String username) async {
    try {
      await _dio.post('/auth/password-reset/', data: {'username': username});
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> confirmarResetPassword({
    required String codigo,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      await _dio.post('/auth/password-reset/confirm/', data: {
        'codigo': codigo,
        'new_password': newPassword,
        'new_password2': newPassword2,
      });
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final authDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(
    ref.watch(dioProvider),
    ref.watch(secureStorageProvider),
  );
});