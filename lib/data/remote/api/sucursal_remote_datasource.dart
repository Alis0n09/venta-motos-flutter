import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/sucursal.dart';
import 'dio_client.dart';

abstract class SucursalRemoteDatasource {
  Future<List<Sucursal>> getSucursales({
    String? nombre,
    String? ciudad,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });

  Future<Sucursal> createSucursal(Map<String, dynamic> payload);
  Future<Sucursal> updateSucursal(int id, Map<String, dynamic> payload);
  Future<void> deleteSucursal(int id);
}

class SucursalRemoteDatasourceImpl implements SucursalRemoteDatasource {
  final Dio _dio;

  SucursalRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Sucursal>> getSucursales({
    String? nombre,
    String? ciudad,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/sucursales/', queryParameters: {
        'page_size': pageSize ?? 100,
        if (nombre != null && nombre.isNotEmpty) 'nombre': nombre,
        if (ciudad != null && ciudad.isNotEmpty) 'ciudad': ciudad,
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Sucursal.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Sucursal> createSucursal(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/sucursales/', data: payload);
      return Sucursal.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Sucursal> updateSucursal(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/sucursales/$id/', data: payload);
      return Sucursal.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteSucursal(int id) async {
    try {
      await _dio.delete('/sucursales/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final sucursalDatasourceProvider = Provider<SucursalRemoteDatasource>((ref) {
  return SucursalRemoteDatasourceImpl(ref.watch(dioProvider));
});
