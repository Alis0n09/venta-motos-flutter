import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/venta.dart';
import 'dio_client.dart';

abstract class VentaRemoteDatasource {
  Future<List<Venta>> getVentas();
}

class VentaRemoteDatasourceImpl implements VentaRemoteDatasource {
  final Dio _dio;

  VentaRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Venta>> getVentas() async {
    try {
      final res = await _dio.get('/ventas/', queryParameters: {'page_size': 200});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Venta.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final ventaDatasourceProvider = Provider<VentaRemoteDatasource>((ref) {
  return VentaRemoteDatasourceImpl(ref.watch(dioProvider));
});