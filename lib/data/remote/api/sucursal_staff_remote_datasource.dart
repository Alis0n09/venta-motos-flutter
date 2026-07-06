import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/sucursal_staff.dart';
import 'dio_client.dart';

abstract class SucursalStaffRemoteDatasource {
  Future<List<SucursalStaff>> getSucursalStaff({
    int? staff,
    int? sucursal,
    String? fechaAsignacion,
    int? page,
    int? pageSize,
  });

  Future<SucursalStaff> createSucursalStaff(Map<String, dynamic> payload);
  Future<SucursalStaff> updateSucursalStaff(int id, Map<String, dynamic> payload);
  Future<void> deleteSucursalStaff(int id);
}

class SucursalStaffRemoteDatasourceImpl implements SucursalStaffRemoteDatasource {
  final Dio _dio;

  SucursalStaffRemoteDatasourceImpl(this._dio);

  @override
  Future<List<SucursalStaff>> getSucursalStaff({
    int? staff,
    int? sucursal,
    String? fechaAsignacion,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/sucursal-staff/', queryParameters: {
        'page_size': pageSize ?? 200,
        if (staff != null) 'staff': staff,
        if (sucursal != null) 'sucursal': sucursal,
        if (fechaAsignacion != null && fechaAsignacion.isNotEmpty) 'fecha_asignacion': fechaAsignacion,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => SucursalStaff.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<SucursalStaff> createSucursalStaff(Map<String, dynamic> payload) async {
    try {
      final res = await _dio.post('/sucursal-staff/', data: payload);
      return SucursalStaff.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<SucursalStaff> updateSucursalStaff(int id, Map<String, dynamic> payload) async {
    try {
      final res = await _dio.patch('/sucursal-staff/$id/', data: payload);
      return SucursalStaff.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteSucursalStaff(int id) async {
    try {
      await _dio.delete('/sucursal-staff/$id/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final sucursalStaffDatasourceProvider = Provider<SucursalStaffRemoteDatasource>((ref) {
  return SucursalStaffRemoteDatasourceImpl(ref.watch(dioProvider));
});
