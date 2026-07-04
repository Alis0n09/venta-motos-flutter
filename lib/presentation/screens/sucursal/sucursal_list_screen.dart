// lib/presentation/screens/sucursal/sucursal_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/sucursal_admin_provider.dart';
import '../../providers/sucursal_provider.dart';

class SucursalListScreen extends ConsumerStatefulWidget {
  const SucursalListScreen({super.key});

  @override
  ConsumerState<SucursalListScreen> createState() => _SucursalListScreenState();
}

class _SucursalListScreenState extends ConsumerState<SucursalListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmarEliminar(int id, String nombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar sucursal?'),
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

    final exito = await ref.read(sucursalAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Sucursal eliminada' : 'No se pudo eliminar la sucursal'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sucursalState = ref.watch(sucursalProvider);
    final adminState = ref.watch(sucursalAdminProvider);
    final authState = ref.watch(authProvider);
    final ciudadesAsync = ref.watch(sucursalesTodasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sucursales')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(sucursalProvider.notifier).loadSucursales(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar sucursal...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(sucursalProvider.notifier).buscar('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) => ref.read(sucursalProvider.notifier).buscar(value),
            ),
            const SizedBox(height: 12),

            ciudadesAsync.when(
              data: (todas) {
                final ciudades = todas.map((s) => s.ciudad).toSet().toList()..sort();
                return DropdownButtonFormField<String>(
                  initialValue: sucursalState.ciudadSeleccionada,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                    ...ciudades.map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c, overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                    ),
                  ],
                  onChanged: (v) => ref.read(sucursalProvider.notifier).filtrarPorCiudad(v),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),

            Text('${sucursalState.sucursales.length} resultados', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 12),

            if (sucursalState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (sucursalState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(sucursalState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (sucursalState.sucursales.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('No se encontraron sucursales', style: AppTextStyles.bodySecondary)),
              )
            else
              for (final sucursal in sucursalState.sucursales) ...[
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(sucursal.nombre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('${sucursal.direccion}, ${sucursal.ciudad}'),
                        if (sucursal.telefono != null && sucursal.telefono!.isNotEmpty)
                          Text(sucursal.telefono!),
                      ],
                    ),
                    isThreeLine: sucursal.telefono != null && sucursal.telefono!.isNotEmpty,
                    trailing: authState.isStaff
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                                onPressed: () => context.push('/sucursales/${sucursal.id}/editar', extra: sucursal),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: adminState.isLoading
                                    ? null
                                    : () => _confirmarEliminar(sucursal.id, sucursal.nombre),
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
      floatingActionButton: authState.isStaff
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/sucursales/nuevo'),
              icon: const Icon(Icons.add),
              label: const Text('Agregar'),
            )
          : null,
    );
  }
}
