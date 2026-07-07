import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repuesto_admin_provider.dart';

class AdminRepuestosScreen extends ConsumerWidget {
  const AdminRepuestosScreen({super.key});

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, int id, String nombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar repuesto?'),
        content: Text('Vas a eliminar "$nombre".'),
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

    final exito = await ref.read(repuestoAdminProvider.notifier).eliminar(id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Repuesto eliminado' : 'No se pudo eliminar'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repuestosAsync = ref.watch(repuestosProvider);
    final authState = ref.watch(authProvider);
    final adminState = ref.watch(repuestoAdminProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Repuestos')),
      body: repuestosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('No se pudieron cargar los repuestos')),
        data: (repuestos) {
          if (repuestos.isEmpty) {
            return const Center(child: Text('No hay repuestos registrados', style: AppTextStyles.bodySecondary));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: repuestos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final repuesto = repuestos[index];
              return Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  title: Text(repuesto.nombre),
                  subtitle: Text(
                    '${repuesto.marcaCompatibleNombre ?? 'Universal'} · Stock: ${repuesto.stock} · \$${repuesto.precio.toStringAsFixed(0)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                        onPressed: () => context.push('/admin/repuestos/editar', extra: repuesto),
                      ),
                      if (authState.isAdmin)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error),
                          onPressed: adminState.isLoading
                              ? null
                              : () => _confirmarEliminar(context, ref, repuesto.id, repuesto.nombre),
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
        onPressed: () => context.push('/admin/repuestos/crear'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo repuesto'),
      ),
    );
  }
}