import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/cliente.dart';
import 'dio_client.dart';

abstract class ClienteRemoteDatasource {
  Future<List<Cliente>> getClientes();
}

class ClienteRemoteDatasourceImpl implements ClienteRemoteDatasource {
  final Dio _dio;

  ClienteRemoteDatasourceImpl(this._dio);

  @override
  Future<List<Cliente>> getClientes() async {
    try {
      final res = await _dio.get('/clientes/', queryParameters: {'page_size': 200});
      final data = res.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Cliente.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final clienteDatasourceProvider = Provider<ClienteRemoteDatasource>((ref) {
  return ClienteRemoteDatasourceImpl(ref.watch(dioProvider));
});
