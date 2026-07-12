import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/compra.dart';
import 'dio_client.dart';

abstract class CompraRemoteDatasource {
  Future<List<Compra>> getCompras({
    int? proveedor,
    int? sucursalDestino,
    String? fecha,
    double? totalMin,
    double? totalMax,
    int? page,
    int? pageSize,
  });

  Future<Compra> createCompra(Map<String, dynamic> payload);
}

class CompraRemoteDatasourceImpl implements CompraRemoteDatasource {
  final Dio _dio;

  CompraRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Compra>> getCompras({
    int? proveedor,
    int? sucursalDestino,
    String? fecha,
    double? totalMin,
    double? totalMax,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/compras/', queryParameters: {
        'page_size': pageSize ?? 200,
        if (proveedor != null) 'proveedor': proveedor,
        if (sucursalDestino != null) 'sucursal_destino': sucursalDestino,
        if (fecha != null && fecha.isNotEmpty) 'fecha': fecha,
        if (totalMin != null) 'total_min': totalMin,
        if (totalMax != null) 'total_max': totalMax,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Compra.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Compra> createCompra(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/compras/', data: payload);
      return Compra.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final compraDatasourceProvider = Provider<CompraRemoteDatasource>((ref) {
  return CompraRemoteDatasourceImpl(ref.watch(dioProvider));
});
