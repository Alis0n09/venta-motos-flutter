import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/log_actividad.dart';
import 'dio_client.dart';

abstract class LogsActividadRemoteDatasource {
  Future<List<LogActividad>> getLogs({
    int? usuario,
    String? accion,
    String? entidad,
    String? fechaDesde,
    String? fechaHasta,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });
}

class LogsActividadRemoteDatasourceImpl implements LogsActividadRemoteDatasource {
  final Dio _dio;

  LogsActividadRemoteDatasourceImpl(this._dio);

  @override
  Future<List<LogActividad>> getLogs({
    int? usuario,
    String? accion,
    String? entidad,
    String? fechaDesde,
    String? fechaHasta,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async {
    try {
      final res = await _dio.get('/logs-actividad/', queryParameters: {
        'page_size': pageSize ?? 200,
        'ordering': ordering ?? '-fecha',
        if (usuario != null) 'usuario': usuario,
        if (accion != null && accion.isNotEmpty) 'accion': accion,
        if (entidad != null && entidad.isNotEmpty) 'entidad': entidad,
        if (fechaDesde != null && fechaDesde.isNotEmpty) 'fecha_desde': fechaDesde,
        if (fechaHasta != null && fechaHasta.isNotEmpty) 'fecha_hasta': fechaHasta,
        if (search != null && search.isNotEmpty) 'search': search,
        if (page != null) 'page': page,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => LogActividad.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final logsActividadDatasourceProvider = Provider<LogsActividadRemoteDatasource>((ref) {
  return LogsActividadRemoteDatasourceImpl(ref.watch(dioProvider));
});
