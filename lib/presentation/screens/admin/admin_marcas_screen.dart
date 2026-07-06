// lib/presentation/screens/admin/admin_marcas_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/marca_admin_provider.dart';

class AdminMarcasScreen extends ConsumerWidget {
  const AdminMarcasScreen({super.key});

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, int id, String nombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar marca?'),
        content: Text('Vas a eliminar "$nombre". Si hay motos asociadas, no se podrá eliminar.'),
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

    final exito = await ref.read(marcaAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      final adminState = ref.read(marcaAdminProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Marca eliminada' : (adminState.error?.toString() ?? 'No se pudo eliminar')),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marcasAsync = ref.watch(marcasAdminProvider);
    final adminState = ref.watch(marcaAdminProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestionar marcas')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(marcasAdminProvider.future),
        child: marcasAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('No se pudieron cargar las marcas', style: AppTextStyles.bodySecondary)),
            ],
          ),
          data: (marcas) => marcas.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(child: Text('No hay marcas registradas', style: AppTextStyles.bodySecondary)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: marcas.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final marca = marcas[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        title: Text(marca.nombre),
                        subtitle: Text(marca.paisOrigen?.isNotEmpty == true ? marca.paisOrigen! : 'Sin país registrado'),
                        leading: Icon(
                          marca.activa ? Icons.check_circle_outline : Icons.remove_circle_outline,
                          color: marca.activa ? AppColors.success : AppColors.textSecondary,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                              onPressed: () => context.push('/admin/marcas/editar', extra: marca),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: AppColors.error),
                              onPressed: adminState.isLoading
                                  ? null
                                  : () => _confirmarEliminar(context, ref, marca.id, marca.nombre),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/marcas/crear'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva marca'),
      ),
    );
  }
}
