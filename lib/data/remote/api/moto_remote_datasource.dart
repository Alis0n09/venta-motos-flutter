import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/moto.dart';
import 'dio_client.dart';

abstract class MotoRemoteDatasource {
  Future<List<Moto>> getMotos({
    int? marcaId,
    String? search,
  });

  Future<Moto> getMoto(int id);
  Future<Moto> createMoto(Map<String, dynamic> payload);
  Future<Moto> updateMoto(int id, Map<String, dynamic> payload);
  Future<void> deleteMoto(int id);
}

class MotoRemoteDatasourceImpl implements MotoRemoteDatasource {
  final Dio _dio;

  MotoRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Moto>> getMotos({int? marcaId, String? search}) async {
    try {
      final res = await _dio.get('/motos/', queryParameters: {
        'page_size': 50,
        if (marcaId != null) 'marca': marcaId,
        if (search != null && search.isNotEmpty) 'search': search,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Moto.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Moto> getMoto(int id) async {
    try {
      final res = await _dio.get('/motos/$id/');
      return Moto.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Moto> createMoto(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/motos/', data: payload);
      return Moto.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Moto> updateMoto(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/motos/$id/', data: payload);
      return Moto.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteMoto(int id) async {
    try {
      await _dio.delete('/motos/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final motoDatasourceProvider = Provider<MotoRemoteDatasource>((ref) {
  return MotoRemoteDatasourceImpl(ref.watch(dioProvider));
});