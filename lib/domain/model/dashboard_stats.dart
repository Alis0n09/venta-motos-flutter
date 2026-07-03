// lib/domain/model/dashboard_stats.dart

class VentaMensual {
  final String mes; // "Feb", "Mar", etc.
  final double total;

  const VentaMensual({required this.mes, required this.total});
}

class DashboardStats {
  final double ventasEsteMes;
  final double ventasMesAnterior;
  final int motosVendidasEsteMes;
  final int stockTotal;
  final int stockBajoCount;
  final List<VentaMensual> ventasPorMes;
  final List<dynamic> ventasRecientes; // lista de Venta, tipado abajo

  const DashboardStats({
    required this.ventasEsteMes,
    required this.ventasMesAnterior,
    required this.motosVendidasEsteMes,
    required this.stockTotal,
    required this.stockBajoCount,
    required this.ventasPorMes,
    required this.ventasRecientes,
  });

  double get porcentajeCambio {
    if (ventasMesAnterior == 0) return ventasEsteMes > 0 ? 100 : 0;
    return ((ventasEsteMes - ventasMesAnterior) / ventasMesAnterior) * 100;
  }
}