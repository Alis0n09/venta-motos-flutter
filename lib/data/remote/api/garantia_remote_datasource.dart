// lib/data/remote/api/garantia_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/garantia.dart';
import 'dio_client.dart';

abstract class GarantiaRemoteDatasource {
  Future<List<Garantia>> getGarantias();
  Future<List<Garantia>> getGarantiasPorVenta(int ventaId);
  Future<Garantia> createGarantia(Map<String, dynamic> payload);
  Future<Garantia> updateGarantia(int id, Map<String, dynamic> payload);
  Future<void> deleteGarantia(int id);
}

class GarantiaRemoteDatasourceImpl implements GarantiaRemoteDatasource {
  final Dio _dio;

  GarantiaRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Garantia>> getGarantias() async {
    try {
      final res = await _dio.get('/garantias/', queryParameters: {'page_size': 100});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Garantia.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<List<Garantia>> getGarantiasPorVenta(int ventaId) async {
    try {
      final res = await _dio.get('/garantias/', queryParameters: {'venta': ventaId});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Garantia.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Garantia> createGarantia(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/garantias/', data: payload);
      return Garantia.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Garantia> updateGarantia(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/garantias/$id/', data: payload);
      return Garantia.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteGarantia(int id) async {
    try {
      await _dio.delete('/garantias/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final garantiaDatasourceProvider = Provider<GarantiaRemoteDatasource>((ref) {
  return GarantiaRemoteDatasourceImpl(ref.watch(dioProvider));
});