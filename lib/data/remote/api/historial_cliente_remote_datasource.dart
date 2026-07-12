import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/historial_cliente.dart';
import 'dio_client.dart';

abstract class HistorialClienteRemoteDatasource {
  /// El cliente autenticado ve solo su propio historial.
  Future<List<HistorialCliente>> getMiHistorial();

  /// Staff/admin ve el historial de todos los clientes.
  /// [search] busca por cédula, nombre o apellido del cliente (texto libre).
  Future<List<HistorialCliente>> getHistorial({String? search, String? tipoEvento});
}

class HistorialClienteRemoteDatasourceImpl implements HistorialClienteRemoteDatasource {
  final Dio _dio;

  HistorialClienteRemoteDatasourceImpl(this._dio);

  @override
  Future<List<HistorialCliente>> getMiHistorial() async {
    try {
      final res = await _dio.get('/historial-cliente/mi-historial/', queryParameters: {
        'page_size': 100,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => HistorialCliente.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<List<HistorialCliente>> getHistorial({String? search, String? tipoEvento}) async {
    try {
      final res = await _dio.get('/historial-cliente/', queryParameters: {
        'page_size': 100,
        if (search != null && search.isNotEmpty) 'search': search,
        if (tipoEvento != null && tipoEvento.isNotEmpty) 'tipo_evento': tipoEvento,
      });
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => HistorialCliente.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final historialClienteDatasourceProvider = Provider<HistorialClienteRemoteDatasource>((ref) {
  return HistorialClienteRemoteDatasourceImpl(ref.watch(dioProvider));
});