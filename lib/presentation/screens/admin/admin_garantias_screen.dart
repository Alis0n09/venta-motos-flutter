// lib/presentation/screens/admin/admin_garantias_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/garantia.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/garantia_admin_provider.dart';

class AdminGarantiasScreen extends ConsumerWidget {
  const AdminGarantiasScreen({super.key});

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, int id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar garantía?'),
        content: const Text('Esta acción no se puede deshacer.'),
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

    final exito = await ref.read(garantiaAdminProvider.notifier).eliminar(id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Garantía eliminada' : 'No se pudo eliminar'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garantiasAsync = ref.watch(garantiasProvider);
    final authState = ref.watch(authProvider);
    final adminState = ref.watch(garantiaAdminProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Garantías')),
      body: garantiasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('No se pudieron cargar las garantías')),
        data: (garantias) {
          if (garantias.isEmpty) {
            return const Center(child: Text('No hay garantías registradas', style: AppTextStyles.bodySecondary));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: garantias.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final garantia = garantias[index];
              return Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  title: Text('Garantía #${garantia.id} — Venta #${garantia.venta}'),
                  subtitle: Text(
                    '${garantia.tipo} · ${DateFormat('dd/MM/yyyy').format(garantia.fechaInicio)} '
                    'a ${DateFormat('dd/MM/yyyy').format(garantia.fechaFin)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                        onPressed: () => context.push('/admin/garantias/editar', extra: garantia),
                      ),
                      if (authState.isAdmin)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error),
                          onPressed: adminState.isLoading ? null : () => _confirmarEliminar(context, ref, garantia.id),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/garantias/crear'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva garantía'),
      ),
    );
  }
}