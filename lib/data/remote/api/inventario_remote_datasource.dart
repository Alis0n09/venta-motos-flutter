import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/inventario.dart';
import 'dio_client.dart';

abstract class InventarioRemoteDatasource {
  Future<List<Inventario>> getInventarios();
}

class InventarioRemoteDatasourceImpl implements InventarioRemoteDatasource {
  final Dio _dio;

  InventarioRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Inventario>> getInventarios() async {
    try {
      final res = await _dio.get('/inventario/', queryParameters: {'page_size': 200});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Inventario.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final inventarioDatasourceProvider = Provider<InventarioRemoteDatasource>((ref) {
  return InventarioRemoteDatasourceImpl(ref.watch(dioProvider));
});