import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/repuesto.dart';
import 'dio_client.dart';

abstract class RepuestoRemoteDatasource {
  Future<List<Repuesto>> getRepuestos();
  Future<Repuesto> createRepuesto(Map<String, dynamic> payload);
  Future<Repuesto> updateRepuesto(int id, Map<String, dynamic> payload);
  Future<void> deleteRepuesto(int id);
}

class RepuestoRemoteDatasourceImpl implements RepuestoRemoteDatasource {
  final Dio _dio;

  RepuestoRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Repuesto>> getRepuestos() async {
    try {
      final res = await _dio.get('/repuestos/', queryParameters: {'page_size': 100});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Repuesto.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Repuesto> createRepuesto(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/repuestos/', data: payload);
      return Repuesto.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Repuesto> updateRepuesto(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/repuestos/$id/', data: payload);
      return Repuesto.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteRepuesto(int id) async {
    try {
      await _dio.delete('/repuestos/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final repuestoDatasourceProvider = Provider<RepuestoRemoteDatasource>((ref) {
  return RepuestoRemoteDatasourceImpl(ref.watch(dioProvider));
});