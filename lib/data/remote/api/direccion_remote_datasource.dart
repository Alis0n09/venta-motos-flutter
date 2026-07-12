import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/direccion.dart';
import 'dio_client.dart';

abstract class DireccionRemoteDatasource {
  Future<List<Direccion>> getDirecciones({
    int? cliente,
    String? ciudad,
    String? provincia,
    bool? principal,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });

  Future<Direccion> createDireccion(Map<String, dynamic> payload);
  Future<Direccion> updateDireccion(int id, Map<String, dynamic> payload);
  Future<void> deleteDireccion(int id);
}

class DireccionRemoteDatasourceImpl implements DireccionRemoteDatasource {
  final Dio _dio;

  DireccionRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Direccion>> getDirecciones({
    int? cliente,
    String? ciudad,
    String? provincia,
    bool? principal,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/direcciones/', queryParameters: {
        'page_size': pageSize ?? 200,
        if (cliente != null) 'cliente': cliente,
        if (ciudad != null && ciudad.isNotEmpty) 'ciudad': ciudad,
        if (provincia != null && provincia.isNotEmpty) 'provincia': provincia,
        if (principal != null) 'principal': principal,
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Direccion.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Direccion> createDireccion(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/direcciones/', data: payload);
      return Direccion.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Direccion> updateDireccion(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/direcciones/$id/', data: payload);
      return Direccion.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteDireccion(int id) async {
    try {
      await _dio.delete('/direcciones/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final direccionDatasourceProvider = Provider<DireccionRemoteDatasource>((ref) {
  return DireccionRemoteDatasourceImpl(ref.watch(dioProvider));
});
