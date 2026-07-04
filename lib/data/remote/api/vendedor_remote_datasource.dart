import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/vendedor_simple.dart';
import 'dio_client.dart';

abstract class VendedorRemoteDatasource {
  Future<List<VendedorSimple>> getVendedores();
}

class VendedorRemoteDatasourceImpl implements VendedorRemoteDatasource {
  final Dio _dio;

  VendedorRemoteDatasourceImpl(this._dio);

  @override
  Future<List<VendedorSimple>> getVendedores() async {
    try {
      final res = await _dio.get('/vendedores/', queryParameters: {'page_size': 100});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => VendedorSimple.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final vendedorDatasourceProvider = Provider<VendedorRemoteDatasource>((ref) {
  return VendedorRemoteDatasourceImpl(ref.watch(dioProvider));
});
