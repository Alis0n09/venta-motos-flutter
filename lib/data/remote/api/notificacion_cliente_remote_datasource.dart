import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/notificacion_cliente.dart';
import 'dio_client.dart';

abstract class NotificacionClienteRemoteDatasource {
  /// El cliente autenticado ve solo sus propias notificaciones.
  Future<List<NotificacionCliente>> getMisNotificaciones();

  /// Marca una notificación puntual como leída.
  Future<void> marcarLeida(int id);
}

class NotificacionClienteRemoteDatasourceImpl implements NotificacionClienteRemoteDatasource {
  final Dio _dio;

  NotificacionClienteRemoteDatasourceImpl(this._dio);

  @override
  Future<List<NotificacionCliente>> getMisNotificaciones() async {
    try {
      final res = await _dio.get('/notificaciones-cliente/mis-notificaciones/', queryParameters: {
        'page_size': 100,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => NotificacionCliente.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> marcarLeida(int id) async {
    try {
      await _dio.patch('/notificaciones-cliente/$id/marcar-leida/');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final notificacionClienteDatasourceProvider = Provider<NotificacionClienteRemoteDatasource>((ref) {
  return NotificacionClienteRemoteDatasourceImpl(ref.watch(dioProvider));
});