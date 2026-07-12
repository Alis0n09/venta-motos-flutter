import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/venta.dart';
import '../../../domain/model/venta_admin.dart';
import 'dio_client.dart';

abstract class VentaRemoteDatasource {
  Future<List<Venta>> getVentas();
  Future<List<VentaAdmin>> getMisCompras();
  Future<VentaAdmin> getVenta(int id);
  Future<VentaAdmin> comprar({required String metodoPago, required List<Map<String, dynamic>> items});
  Future<Venta> updateVenta(int id, Map<String, dynamic> payload);
  Future<void> deleteVenta(int id);
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

  @override
  Future<List<VentaAdmin>> getMisCompras() async {
    try {
      final res = await _dio.get('/ventas/mis-compras/', queryParameters: {'page_size': 200});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => VentaAdmin.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<VentaAdmin> getVenta(int id) async {
    try {
      final res = await _dio.get('/ventas/$id/');
      return VentaAdmin.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<VentaAdmin> comprar({required String metodoPago, required List<Map<String, dynamic>> items}) async {
    try {
      final res = await _dio.post('/ventas/comprar/', data: {
        'metodo_pago': metodoPago,
        'items': items,
      });
      return VentaAdmin.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Venta> updateVenta(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/ventas/$id/', data: payload);
      return Venta.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteVenta(int id) async {
    try {
      await _dio.delete('/ventas/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final ventaDatasourceProvider = Provider<VentaRemoteDatasource>((ref) {
  return VentaRemoteDatasourceImpl(ref.watch(dioProvider));
});