// lib/data/remote/api/resena_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/resena.dart';
import 'dio_client.dart';

abstract class ResenaRemoteDatasource {
  Future<List<Resena>> getResenasPorMoto(int motoId);
  Future<Resena> crearResena({required int motoId, required int rating, required String comentario});
  Future<void> eliminarResena(int id);
}

class ResenaRemoteDatasourceImpl implements ResenaRemoteDatasource {
  final Dio _dio;

  ResenaRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Resena>> getResenasPorMoto(int motoId) async {
    try {
      final res = await _dio.get('/resenas/', queryParameters: {
        'moto': motoId,
        'page_size': 50,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Resena.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Resena> crearResena({required int motoId, required int rating, required String comentario}) async {
    try {
      final res = await _dio.post('/resenas/', data: {
        'moto': motoId,
        'rating': rating,
        'comentario': comentario,
      });
      return Resena.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> eliminarResena(int id) async {
    try {
      await _dio.delete('/resenas/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final resenaDatasourceProvider = Provider<ResenaRemoteDatasource>((ref) {
  return ResenaRemoteDatasourceImpl(ref.watch(dioProvider));
});