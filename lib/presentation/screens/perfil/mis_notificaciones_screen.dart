// lib/presentation/screens/perfil/mis_notificaciones_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/notificacion_cliente.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/notificacion_cliente_provider.dart';

class MisNotificacionesScreen extends ConsumerWidget {
  const MisNotificacionesScreen({super.key});

  IconData _iconoTipo(String tipo) {
    switch (tipo) {
      case 'promocion':
        return Icons.local_offer_outlined;
      case 'recordatorio':
        return Icons.notifications_active_outlined;
      case 'pago':
        return Icons.payments_outlined;
      case 'compra':
        return Icons.shopping_bag_outlined;
      case 'mantenimiento':
        return Icons.build_outlined;
      case 'financiamiento':
        return Icons.account_balance_outlined;
      case 'garantia':
        return Icons.verified_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  Future<void> _marcarLeida(BuildContext context, WidgetRef ref, NotificacionCliente n) async {
    if (n.leido) return;
    final exito = await ref.read(notificacionClienteProvider.notifier).marcarLeida(n.id);
    if (context.mounted && !exito) {
      final error = ref.read(notificacionClienteProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'No se pudo marcar como leída'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificacionesAsync = ref.watch(misNotificacionesProvider);
    final notifState = ref.watch(notificacionClienteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(misNotificacionesProvider.future),
        child: notificacionesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('No se pudieron cargar tus notificaciones', style: AppTextStyles.bodySecondary)),
            ],
          ),
          data: (notificaciones) => notificaciones.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(child: Text('No tienes notificaciones', style: AppTextStyles.bodySecondary)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: notificaciones.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final n = notificaciones[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      color: n.leido ? null : AppColors.accentLight.withValues(alpha: 0.35),
                      child: ListTile(
                        onTap: notifState.isLoading ? null : () => _marcarLeida(context, ref, n),
                        leading: CircleAvatar(
                          backgroundColor: n.leido ? AppColors.surface : AppColors.accentLight,
                          child: Icon(
                            _iconoTipo(n.tipo),
                            color: n.leido ? AppColors.textSecondary : AppColors.accent,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          n.mensaje,
                          style: AppTextStyles.body.copyWith(
                            fontWeight: n.leido ? FontWeight.normal : FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(n.fecha)),
                        trailing: n.leido
                            ? null
                            : Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
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