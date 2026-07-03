// lib/presentation/providers/dashboard_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/api/inventario_remote_datasource.dart';
import '../../data/remote/api/venta_remote_datasource.dart';
import '../../domain/model/dashboard_stats.dart';
import '../../domain/model/venta.dart';

const _umbralStockBajo = 5;
const _mesesAbrev = [
  'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
  'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
];

final dashboardProvider = FutureProvider<DashboardStats>((ref) async {
  final ventaDatasource = ref.watch(ventaDatasourceProvider);
  final inventarioDatasource = ref.watch(inventarioDatasourceProvider);

  final ventas = await ventaDatasource.getVentas();
  final inventarios = await inventarioDatasource.getInventarios();

  final ahora = DateTime.now();
  final mesActual = DateTime(ahora.year, ahora.month);
  final mesAnterior = DateTime(ahora.year, ahora.month - 1);

  bool esDelMes(Venta v, DateTime mes) =>
      v.fechaVenta.year == mes.year && v.fechaVenta.month == mes.month;

  final ventasEsteMes = ventas.where((v) => esDelMes(v, mesActual)).fold<double>(
        0, (sum, v) => sum + v.total,
      );

  final ventasMesAnteriorTotal = ventas.where((v) => esDelMes(v, mesAnterior)).fold<double>(
        0, (sum, v) => sum + v.total,
      );

  final motosVendidasEsteMes = ventas
      .where((v) => esDelMes(v, mesActual))
      .fold<int>(0, (sum, v) => sum + v.unidadesVendidas);

  final stockTotal = inventarios.fold<int>(0, (sum, i) => sum + i.cantidad);
  final stockBajoCount = inventarios.where((i) => i.cantidad < _umbralStockBajo).length;

  // Últimos 5 meses, incluyendo el actual
  final ventasPorMes = List.generate(5, (i) {
    final mes = DateTime(ahora.year, ahora.month - (4 - i));
    final totalMes = ventas.where((v) => esDelMes(v, mes)).fold<double>(
          0, (sum, v) => sum + v.total,
        );
    return VentaMensual(mes: _mesesAbrev[mes.month - 1], total: totalMes);
  });

  final ventasRecientes = List<Venta>.from(ventas)
    ..sort((a, b) => b.fechaVenta.compareTo(a.fechaVenta));

  return DashboardStats(
    ventasEsteMes: ventasEsteMes,
    ventasMesAnterior: ventasMesAnteriorTotal,
    motosVendidasEsteMes: motosVendidasEsteMes,
    stockTotal: stockTotal,
    stockBajoCount: stockBajoCount,
    ventasPorMes: ventasPorMes,
    ventasRecientes: ventasRecientes.take(5).toList(),
  );
});