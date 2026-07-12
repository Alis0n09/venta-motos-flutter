import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/marca.dart';
import 'dio_client.dart';

abstract class MarcaRemoteDatasource {
  Future<List<Marca>> getMarcas({bool soloActivas = true});
  Future<Marca> createMarca(Map<String, dynamic> payload);
  Future<Marca> updateMarca(int id, Map<String, dynamic> payload);
  Future<void> deleteMarca(int id);
}

class MarcaRemoteDatasourceImpl implements MarcaRemoteDatasource {
  final Dio _dio;

  MarcaRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Marca>> getMarcas({bool soloActivas = true}) async {
    try {
      final res = await _dio.get('/marcas/', queryParameters: {
        if (soloActivas) 'activa': true,
        'page_size': 100,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Marca.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Marca> createMarca(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/marcas/', data: payload);
      return Marca.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Marca> updateMarca(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/marcas/$id/', data: payload);
      return Marca.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteMarca(int id) async {
    try {
      await _dio.delete('/marcas/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final marcaDatasourceProvider = Provider<MarcaRemoteDatasource>((ref) {
  return MarcaRemoteDatasourceImpl(ref.watch(dioProvider));
});
