import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/api/historial_cliente_remote_datasource.dart';
import '../../domain/model/historial_cliente.dart';

/// Historial del cliente autenticado (pantalla "Mi historial" en Perfil).
final miHistorialProvider = FutureProvider.autoDispose<List<HistorialCliente>>((ref) async {
  final datasource = ref.watch(historialClienteDatasourceProvider);
  return datasource.getMiHistorial();
});

/// Historial de todos los clientes para el panel admin, opcionalmente
/// filtrado por búsqueda de texto (cédula, nombre o apellido del cliente).
/// Pasa `null` para ver todos.
final historialClientesAdminProvider =
    FutureProvider.autoDispose.family<List<HistorialCliente>, String?>((ref, search) async {
  final datasource = ref.watch(historialClienteDatasourceProvider);
  return datasource.getHistorial(search: search);
});