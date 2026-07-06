// lib/presentation/providers/cliente_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/api/cliente_remote_datasource.dart';
import '../../domain/model/cliente.dart';

// Solo lectura: se usa para poblar el selector de Cliente en el formulario de Dirección.
final clientesProvider = FutureProvider.autoDispose<List<Cliente>>((ref) async {
  final datasource = ref.watch(clienteDatasourceProvider);
  return datasource.getClientes();
});
