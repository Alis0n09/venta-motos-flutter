import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/historial_precio.dart';
import 'dio_client.dart';

abstract class HistorialPrecioRemoteDatasource {
  Future<List<HistorialPrecio>> getHistorial({int? motoId});
}

class HistorialPrecioRemoteDatasourceImpl implements HistorialPrecioRemoteDatasource {
  final Dio _dio;

  HistorialPrecioRemoteDatasourceImpl(this._dio);

  @override
  Future<List<HistorialPrecio>> getHistorial({int? motoId}) async {
    try {
      final res = await _dio.get('/historial-precios/', queryParameters: {
        'page_size': 100,
        if (motoId != null) 'moto': motoId,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => HistorialPrecio.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final historialPrecioDatasourceProvider = Provider<HistorialPrecioRemoteDatasource>((ref) {
  return HistorialPrecioRemoteDatasourceImpl(ref.watch(dioProvider));
});