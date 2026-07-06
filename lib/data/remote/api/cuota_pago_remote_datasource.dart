import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/cuota_pago.dart';
import 'dio_client.dart';

abstract class CuotaPagoRemoteDatasource {
  Future<List<CuotaPago>> getCuotas({int? financiamiento, String? estado});
  Future<CuotaPago> createCuota(Map<String, dynamic> payload);
  Future<CuotaPago> updateCuota(int id, Map<String, dynamic> payload);
  Future<void> deleteCuota(int id);
  Future<Map<String, dynamic>> getStats();
}

class CuotaPagoRemoteDatasourceImpl implements CuotaPagoRemoteDatasource {
  final Dio _dio;

  CuotaPagoRemoteDatasourceImpl(this._dio);

  @override
  Future<List<CuotaPago>> getCuotas({int? financiamiento, String? estado}) async {
    try {
      final res = await _dio.get('/cuotas-pago/', queryParameters: {
        if (financiamiento != null) 'financiamiento': financiamiento,
        if (estado != null) 'estado': estado,
        'page_size': 100,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => CuotaPago.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<CuotaPago> createCuota(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/cuotas-pago/', data: payload);
      return CuotaPago.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<CuotaPago> updateCuota(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/cuotas-pago/$id/', data: payload);
      return CuotaPago.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteCuota(int id) async {
    try {
      await _dio.delete('/cuotas-pago/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getStats() async {
    try {
      final res = await _dio.get('/cuotas-pago/stats/');
      return res.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final cuotaPagoDatasourceProvider = Provider<CuotaPagoRemoteDatasource>((ref) {
  return CuotaPagoRemoteDatasourceImpl(ref.watch(dioProvider));
});