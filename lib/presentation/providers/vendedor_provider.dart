// lib/presentation/providers/vendedor_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/api/vendedor_remote_datasource.dart';
import '../../domain/model/vendedor.dart';

// Solo lectura: se usa para poblar el selector de Staff en el formulario de SucursalStaff.
final vendedoresProvider = FutureProvider.autoDispose<List<Vendedor>>((ref) async {
  final datasource = ref.watch(vendedorDatasourceProvider);
  return datasource.getVendedores();
});
