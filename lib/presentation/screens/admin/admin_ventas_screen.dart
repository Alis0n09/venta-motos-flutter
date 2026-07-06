// lib/presentation/screens/admin/admin_ventas_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/venta_admin_provider.dart';

class AdminVentasScreen extends ConsumerWidget {
  const AdminVentasScreen({super.key});

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, int ventaId) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar venta?'),
        content: Text('Vas a eliminar la venta #$ventaId. Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    final exito = await ref.read(ventaAdminProvider.notifier).eliminar(ventaId);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Venta eliminada' : 'No se pudo eliminar la venta'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ventasAsync = ref.watch(ventasAdminProvider);
    final authState = ref.watch(authProvider);
    final adminState = ref.watch(ventaAdminProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todas las ventas')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(ventasAdminProvider.future),
        child: ventasAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('No se pudieron cargar las ventas', style: AppTextStyles.bodySecondary)),
            ],
          ),
          data: (ventas) => ventas.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(child: Text('No hay ventas registradas', style: AppTextStyles.bodySecondary)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: ventas.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final venta = ventas[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        title: Text(venta.clienteNombre ?? 'Cliente #${venta.id}'),
                        subtitle: Text(
                          '${DateFormat('dd/MM/yyyy').format(venta.fechaVenta)} · '
                          '${venta.metodoPago} · '
                          '${venta.vendedorNombre ?? 'Sin vendedor'}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$${venta.total.toStringAsFixed(0)}', style: AppTextStyles.price),
                            if (venta.metodoPago == 'credito')
                              IconButton(
                                tooltip: 'Financiamiento',
                                icon: const Icon(Icons.credit_score_outlined, color: AppColors.textSecondary),
                                onPressed: () => context.push('/admin/financiamientos/detalle', extra: venta.id),
                              ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                              onPressed: () => context.push('/admin/ventas/editar', extra: venta.id),
                            ),
                            if (authState.isAdmin)
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: adminState.isLoading
                                    ? null
                                    : () => _confirmarEliminar(context, ref, venta.id),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}