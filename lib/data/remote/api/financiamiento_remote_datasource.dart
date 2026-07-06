import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/financiamiento.dart';
import 'dio_client.dart';

abstract class FinanciamientoRemoteDatasource {
  Future<List<Financiamiento>> getFinanciamientos({String? estado, int? venta});
  Future<Financiamiento?> getFinanciamientoPorVenta(int ventaId);
  Future<Financiamiento> createFinanciamiento(Map<String, dynamic> payload);
  Future<Financiamiento> updateFinanciamiento(int id, Map<String, dynamic> payload);
  Future<void> deleteFinanciamiento(int id);
  Future<Map<String, dynamic>> getStats();
}

class FinanciamientoRemoteDatasourceImpl implements FinanciamientoRemoteDatasource {
  final Dio _dio;

  FinanciamientoRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Financiamiento>> getFinanciamientos({String? estado, int? venta}) async {
    try {
      final res = await _dio.get('/financiamientos/', queryParameters: {
        if (estado != null) 'estado': estado,
        if (venta != null) 'venta': venta,
        'page_size': 100,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Financiamiento.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Financiamiento?> getFinanciamientoPorVenta(int ventaId) async {
    final lista = await getFinanciamientos(venta: ventaId);
    return lista.isEmpty ? null : lista.first;
  }

  @override
  Future<Financiamiento> createFinanciamiento(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/financiamientos/', data: payload);
      return Financiamiento.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Financiamiento> updateFinanciamiento(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/financiamientos/$id/', data: payload);
      return Financiamiento.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteFinanciamiento(int id) async {
    try {
      await _dio.delete('/financiamientos/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getStats() async {
    try {
      final res = await _dio.get('/financiamientos/stats/');
      return res.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final financiamientoDatasourceProvider = Provider<FinanciamientoRemoteDatasource>((ref) {
  return FinanciamientoRemoteDatasourceImpl(ref.watch(dioProvider));
});
