import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/cliente_mini.dart';
import '../../../domain/model/mantenimiento.dart';
import 'dio_client.dart';

abstract class MantenimientoRemoteDatasource {
  Future<List<Mantenimiento>> getMantenimientos();
  Future<Mantenimiento> crearMantenimiento(Map<String, dynamic> payload);
  Future<Mantenimiento> editarMantenimiento(int id, Map<String, dynamic> payload);
  Future<void> eliminarMantenimiento(int id);
  Future<List<ClienteMini>> getClientes();
}

class MantenimientoRemoteDatasourceImpl implements MantenimientoRemoteDatasource {
  final Dio _dio;

  MantenimientoRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Mantenimiento>> getMantenimientos() async {
    try {
      final res = await _dio.get('/mantenimientos/', queryParameters: {'page_size': 100});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Mantenimiento.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Mantenimiento> crearMantenimiento(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/mantenimientos/', data: payload);
      return Mantenimiento.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Mantenimiento> editarMantenimiento(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/mantenimientos/$id/', data: payload);
      return Mantenimiento.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> eliminarMantenimiento(int id) async {
    try {
      await _dio.delete('/mantenimientos/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<List<ClienteMini>> getClientes() async {
    try {
      final res = await _dio.get('/clientes/', queryParameters: {'page_size': 200});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => ClienteMini.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final mantenimientoDatasourceProvider = Provider<MantenimientoRemoteDatasource>((ref) {
  return MantenimientoRemoteDatasourceImpl(ref.watch(dioProvider));
});