import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/proveedor.dart';
import 'dio_client.dart';

abstract class ProveedorRemoteDatasource {
  Future<List<Proveedor>> getProveedores({
    String? empresa,
    String? pais,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });

  Future<Proveedor> createProveedor(Map<String, dynamic> payload);
  Future<Proveedor> updateProveedor(int id, Map<String, dynamic> payload);
  Future<void> deleteProveedor(int id);
}

class ProveedorRemoteDatasourceImpl implements ProveedorRemoteDatasource {
  final Dio _dio;

  ProveedorRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Proveedor>> getProveedores({
    String? empresa,
    String? pais,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/proveedores/', queryParameters: {
        'page_size': pageSize ?? 100,
        if (empresa != null && empresa.isNotEmpty) 'empresa': empresa,
        if (pais != null && pais.isNotEmpty) 'pais': pais,
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Proveedor.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Proveedor> createProveedor(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/proveedores/', data: payload);
      return Proveedor.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Proveedor> updateProveedor(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/proveedores/$id/', data: payload);
      return Proveedor.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteProveedor(int id) async {
    try {
      await _dio.delete('/proveedores/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final proveedorDatasourceProvider = Provider<ProveedorRemoteDatasource>((ref) {
  return ProveedorRemoteDatasourceImpl(ref.watch(dioProvider));
});
