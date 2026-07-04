import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/perfil.dart';
import 'dio_client.dart';

abstract class PerfilRemoteDatasource {
  Future<PerfilCuenta> getCuenta();
  Future<PerfilCuenta> updateCuenta(Map<String, dynamic> payload);
  Future<PerfilCliente> getCliente();
  Future<PerfilCliente> updateCliente(Map<String, dynamic> payload);
  Future<void> cambiarPassword({
    required String currentPassword,
    required String newPassword,
    required String newPassword2,
  });
}

class PerfilRemoteDatasourceImpl implements PerfilRemoteDatasource {
  final Dio _dio;

  PerfilRemoteDatasourceImpl(this._dio);

  @override
  Future<PerfilCuenta> getCuenta() async {
    try {
      final res = await _dio.get('/users/profile/');
      return PerfilCuenta.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<PerfilCuenta> updateCuenta(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/users/profile/', data: payload);
      return PerfilCuenta.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<PerfilCliente> getCliente() async {
    try {
      final res = await _dio.get('/clientes/me/');
      return PerfilCliente.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<PerfilCliente> updateCliente(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/clientes/me/', data: payload);
      return PerfilCliente.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> cambiarPassword({
    required String currentPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      await _dio.post('/users/change-password/', data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password2': newPassword2,
      });
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final perfilDatasourceProvider = Provider<PerfilRemoteDatasource>((ref) {
  return PerfilRemoteDatasourceImpl(ref.watch(dioProvider));
});