import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/detalle_compra.dart';
import 'dio_client.dart';

abstract class DetalleCompraRemoteDatasource {
  Future<DetalleCompra> createDetalleCompra(Map<String, dynamic> payload);
  Future<List<DetalleCompra>> getDetallesByCompra(int compraId);
}

class DetalleCompraRemoteDatasourceImpl implements DetalleCompraRemoteDatasource {
  final Dio _dio;

  DetalleCompraRemoteDatasourceImpl(this._dio);

  @override
  Future<DetalleCompra> createDetalleCompra(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/detalle-compras/', data: payload);
      return DetalleCompra.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<List<DetalleCompra>> getDetallesByCompra(int compraId) async {
    try {
      final res = await _dio.get('/detalle-compras/', queryParameters: {
        'compra': compraId,
        'page_size': 200,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => DetalleCompra.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final detalleCompraDatasourceProvider = Provider<DetalleCompraRemoteDatasource>((ref) {
  return DetalleCompraRemoteDatasourceImpl(ref.watch(dioProvider));
});
