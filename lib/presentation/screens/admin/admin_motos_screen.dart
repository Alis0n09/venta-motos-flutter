// lib/presentation/screens/admin/admin_motos_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/moto_admin_provider.dart';

class AdminMotosScreen extends ConsumerWidget {
  const AdminMotosScreen({super.key});

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, int motoId, String nombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar moto?'),
        content: Text('Vas a eliminar "$nombre". Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    final exito = await ref.read(motoAdminProvider.notifier).eliminar(motoId);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Moto eliminada' : 'No se pudo eliminar la moto'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(catalogProvider);
    final authState = ref.watch(authProvider);
    final adminState = ref.watch(motoAdminProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestionar motos')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(catalogProvider.notifier).loadMotos(),
        child: catalogState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : catalogState.motos.isEmpty
                ? const Center(child: Text('No hay motos registradas', style: AppTextStyles.bodySecondary))
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: catalogState.motos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final moto = catalogState.motos[index];
                      return Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          title: Text('${moto.marcaNombre} ${moto.modelo}'),
                          subtitle: Text('\$${moto.precio.toStringAsFixed(0)} · Stock: ${moto.stock}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                                onPressed: () => context.push('/admin/motos/editar', extra: moto),
                              ),
                              // Solo admin puede eliminar (vendedor/bodeguero solo editan)
                              if (authState.isAdmin)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                  onPressed: adminState.isLoading
                                      ? null
                                      : () => _confirmarEliminar(
                                            context, ref, moto.id, '${moto.marcaNombre} ${moto.modelo}',
                                          ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/motos/crear'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva moto'),
      ),
    );
  }
}