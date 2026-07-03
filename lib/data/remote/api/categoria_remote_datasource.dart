import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/categoria.dart';
import 'dio_client.dart';

abstract class CategoriaRemoteDatasource {
  Future<List<Categoria>> getCategorias();
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
}

final categoriaDatasourceProvider = Provider<CategoriaRemoteDatasource>((ref) {
  return CategoriaRemoteDatasourceImpl(ref.watch(dioProvider));
});