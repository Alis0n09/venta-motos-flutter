import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/categoria.dart';
import 'dio_client.dart';

abstract class CategoriaRemoteDatasource {
  Future<List<Categoria>> getCategorias();
  Future<Categoria> createCategoria(Map<String, dynamic> payload);
  Future<Categoria> updateCategoria(int id, Map<String, dynamic> payload);
  Future<void> deleteCategoria(int id);
}

class CategoriaRemoteDatasourceImpl implements CategoriaRemoteDatasource {
  final Dio _dio;

  CategoriaRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Categoria>> getCategorias() async {
    try {
      final res = await _dio.get('/categorias/', queryParameters: {'page_size': 100});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Categoria.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Categoria> createCategoria(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/categorias/', data: payload);
      return Categoria.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Categoria> updateCategoria(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/categorias/$id/', data: payload);
      return Categoria.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteCategoria(int id) async {
    try {
      await _dio.delete('/categorias/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final categoriaDatasourceProvider = Provider<CategoriaRemoteDatasource>((ref) {
  return CategoriaRemoteDatasourceImpl(ref.watch(dioProvider));
});
