import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/api/historial_precio_remote_datasource.dart';
import '../../domain/model/historial_precio.dart';

final historialPreciosProvider = FutureProvider.autoDispose<List<HistorialPrecio>>((ref) async {
  final datasource = ref.watch(historialPrecioDatasourceProvider);
  return datasource.getHistorial();
});

final historialPreciosPorMotoProvider = FutureProvider.autoDispose.family<List<HistorialPrecio>, int>((ref, motoId) async {
  final datasource = ref.watch(historialPrecioDatasourceProvider);
  return datasource.getHistorial(motoId: motoId);
});