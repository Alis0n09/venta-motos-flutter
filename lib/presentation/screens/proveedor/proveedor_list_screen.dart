// lib/presentation/screens/proveedor/proveedor_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/proveedor_admin_provider.dart';
import '../../providers/proveedor_provider.dart';

class ProveedorListScreen extends ConsumerStatefulWidget {
  const ProveedorListScreen({super.key});

  @override
  ConsumerState<ProveedorListScreen> createState() => _ProveedorListScreenState();
}

class _ProveedorListScreenState extends ConsumerState<ProveedorListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmarEliminar(int id, String empresa) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar proveedor?'),
        content: Text('Vas a eliminar "$empresa". Esta acción no se puede deshacer.'),
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

    final exito = await ref.read(proveedorAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Proveedor eliminado' : 'No se pudo eliminar el proveedor'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final proveedorState = ref.watch(proveedorProvider);
    final adminState = ref.watch(proveedorAdminProvider);
    final authState = ref.watch(authProvider);
    final puedeGestionar = authState.isAdmin || authState.isBodeguero;

    final paises = proveedorState.proveedores
        .map((p) => p.pais)
        .whereType<String>()
        .where((p) => p.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Proveedores')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(proveedorProvider.notifier).loadProveedores(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar proveedor...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(proveedorProvider.notifier).buscar('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) => ref.read(proveedorProvider.notifier).buscar(value),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: proveedorState.paisSeleccionado,
              decoration: const InputDecoration(labelText: 'País'),
              isExpanded: true,
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('Todos', overflow: TextOverflow.ellipsis, maxLines: 1),
                ),
                ...paises.map(
                  (p) => DropdownMenuItem(
                    value: p,
                    child: Text(p, overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                ),
              ],
              onChanged: (v) => ref.read(proveedorProvider.notifier).filtrarPorPais(v),
            ),
            const SizedBox(height: 20),

            Text('${proveedorState.proveedores.length} resultados', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 12),

            if (proveedorState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (proveedorState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(proveedorState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (proveedorState.proveedores.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('No se encontraron proveedores', style: AppTextStyles.bodySecondary)),
              )
            else
              for (final proveedor in proveedorState.proveedores) ...[
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(proveedor.empresa),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        if (proveedor.contacto != null && proveedor.contacto!.isNotEmpty)
                          Text(proveedor.contacto!),
                        if (proveedor.correo != null && proveedor.correo!.isNotEmpty)
                          Text(proveedor.correo!),
                        if (proveedor.pais != null && proveedor.pais!.isNotEmpty)
                          Text(proveedor.pais!),
                      ],
                    ),
                    isThreeLine: [proveedor.contacto, proveedor.correo, proveedor.pais]
                            .where((v) => v != null && v.isNotEmpty)
                            .length >
                        1,
                    trailing: puedeGestionar
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                                onPressed: () =>
                                    context.push('/proveedores/${proveedor.id}/editar', extra: proveedor),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: adminState.isLoading
                                    ? null
                                    : () => _confirmarEliminar(proveedor.id, proveedor.empresa),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
              ],
          ],
        ),
      ),
      floatingActionButton: puedeGestionar
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/proveedores/nuevo'),
              icon: const Icon(Icons.add),
              label: const Text('Agregar'),
            )
          : null,
    );
  }
}
