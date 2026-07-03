// lib/presentation/screens/admin/admin_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/dashboard_stats.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dashboard_provider.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  String _formatoCompacto(double valor) {
    if (valor >= 1000) {
      return '\$${(valor / 1000).toStringAsFixed(1)}k';
    }
    return '\$${valor.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final statsAsync = ref.watch(dashboardProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(dashboardProvider.future),
          child: statsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'No se pudieron cargar las estadísticas.\n${error.toString()}',
                  style: AppTextStyles.bodySecondary,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (stats) => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ── Header ──────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PANEL ADMIN', style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
                          const SizedBox(height: 4),
                          Text('Hola, ${authState.user?.username ?? ''}', style: AppTextStyles.heading1),
                        ],
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
                      child: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Tarjeta de ventas del mes ─────────────
                ClipRect(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('VENTAS DEL MES', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                            const SizedBox(height: 8),
                            Text(
                              _formatoCompacto(stats.ventasEsteMes),
                              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: stats.porcentajeCambio >= 0
                                    ? AppColors.success.withValues(alpha: 0.2)
                                    : AppColors.error.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${stats.porcentajeCambio >= 0 ? '▲' : '▼'} ${stats.porcentajeCambio.abs().toStringAsFixed(0)}% '
                                'vs ${_formatoCompacto(stats.ventasMesAnterior)} mes pasado',
                                style: TextStyle(
                                  color: stats.porcentajeCambio >= 0 ? AppColors.success : AppColors.error,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -30,
                        right: -30,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Motos vendidas + Stock ────────────────
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: 'MOTOS VENDIDAS',
                        valor: '${stats.motosVendidasEsteMes}',
                        subtitulo: 'este mes',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        label: 'STOCK',
                        valor: '${stats.stockTotal}',
                        subtitulo: '${stats.stockBajoCount} con stock bajo',
                        subtituloColor: stats.stockBajoCount > 0 ? AppColors.warning : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Gráfico de ventas por mes ──────────────
                Text('Ventas por mes', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                _GraficoVentas(datos: stats.ventasPorMes),

                const SizedBox(height: 28),

                // ── Ventas recientes ──────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ventas recientes', style: AppTextStyles.heading2),
                    TextButton(
                      onPressed: () => context.push('/admin/ventas'),
                      child: const Text('Ver todas', style: TextStyle(color: AppColors.accent)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (stats.ventasRecientes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Aún no hay ventas registradas', style: AppTextStyles.bodySecondary),
                  )
                else
                  for (final venta in stats.ventasRecientes)
                    Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const CircleAvatar(backgroundColor: AppColors.accent),
                        title: Text(venta.clienteNombre ?? 'Cliente'),
                        trailing: Text(
                          '\$${venta.total.toStringAsFixed(0)}',
                          style: AppTextStyles.price,
                        ),
                      ),
                    ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          switch (index) {
            case 1:
              context.push('/admin/motos');
              break;
            case 2:
              context.push('/admin/inventario');
              break;
            case 3:
              context.push('/admin/ventas');
              break;
            case 4:
              context.push('/perfil');
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Panel'),
          NavigationDestination(icon: Icon(Icons.two_wheeler_outlined), label: 'Motos'),
          NavigationDestination(icon: Icon(Icons.warehouse_outlined), label: 'Inventario'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Ventas'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Cuenta'),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String valor;
  final String subtitulo;
  final Color? subtituloColor;

  const _StatCard({
    required this.label,
    required this.valor,
    required this.subtitulo,
    this.subtituloColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Text(valor, style: AppTextStyles.heading1.copyWith(fontSize: 26)),
          const SizedBox(height: 4),
          Text(
            subtitulo,
            style: AppTextStyles.bodySecondary.copyWith(color: subtituloColor ?? AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _GraficoVentas extends StatelessWidget {
  final List<VentaMensual> datos;

  const _GraficoVentas({required this.datos});

  @override
  Widget build(BuildContext context) {
    final maxValor = datos.map((d) => d.total).fold<double>(0, (a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: SizedBox(
        height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < datos.length; i++)
              _Barra(
                mes: datos[i].mes,
                alturaFraccion: maxValor > 0 ? datos[i].total / maxValor : 0,
                esActual: i == datos.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  final String mes;
  final double alturaFraccion;
  final bool esActual;

  const _Barra({required this.mes, required this.alturaFraccion, required this.esActual});

  @override
  Widget build(BuildContext context) {
    final alturaMaxima = 90.0;
    final altura = (alturaFraccion * alturaMaxima).clamp(6.0, alturaMaxima);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: altura,
          decoration: BoxDecoration(
            color: esActual ? AppColors.accent : AppColors.border,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(mes, style: AppTextStyles.bodySecondary.copyWith(fontSize: 12)),
      ],
    );
  }
}