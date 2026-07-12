import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/inventario.dart';
import 'dio_client.dart';

abstract class InventarioRemoteDatasource {
  Future<List<Inventario>> getInventarios({
    int? moto,
    int? sucursal,
    int? cantidadMin,
    int? cantidadMax,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });

  Future<Inventario> createInventario(Map<String, dynamic> payload);
  Future<Inventario> updateInventario(int id, Map<String, dynamic> payload);
  Future<void> deleteInventario(int id);
}

class InventarioRemoteDatasourceImpl implements InventarioRemoteDatasource {
  final Dio _dio;

  InventarioRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Inventario>> getInventarios({
    int? moto,
    int? sucursal,
    int? cantidadMin,
    int? cantidadMax,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/inventario/', queryParameters: {
        'page_size': pageSize ?? 200,
        if (moto != null) 'moto': moto,
        if (sucursal != null) 'sucursal': sucursal,
        if (cantidadMin != null) 'cantidad_min': cantidadMin,
        if (cantidadMax != null) 'cantidad_max': cantidadMax,
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Inventario.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Inventario> createInventario(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/inventario/', data: payload);
      return Inventario.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Inventario> updateInventario(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/inventario/$id/', data: payload);
      return Inventario.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteInventario(int id) async {
    try {
      await _dio.delete('/inventario/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final inventarioDatasourceProvider = Provider<InventarioRemoteDatasource>((ref) {
  return InventarioRemoteDatasourceImpl(ref.watch(dioProvider));
});
