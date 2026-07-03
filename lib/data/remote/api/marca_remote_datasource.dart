import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/marca.dart';
import 'dio_client.dart';

abstract class MarcaRemoteDatasource {
  Future<List<Marca>> getMarcas();
}

class MarcaRemoteDatasourceImpl implements MarcaRemoteDatasource {
  final Dio _dio;

  MarcaRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Marca>> getMarcas() async {
    try {
      final res = await _dio.get('/marcas/', queryParameters: {
        'activa': true,
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
}

final marcaDatasourceProvider = Provider<MarcaRemoteDatasource>((ref) {
  return MarcaRemoteDatasourceImpl(ref.watch(dioProvider));
});