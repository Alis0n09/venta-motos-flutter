// lib/presentation/screens/direccion/direccion_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/cliente.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/cliente_provider.dart';
import '../../providers/direccion_admin_provider.dart';
import '../../providers/direccion_provider.dart';

class DireccionListScreen extends ConsumerStatefulWidget {
  const DireccionListScreen({super.key});

  @override
  ConsumerState<DireccionListScreen> createState() => _DireccionListScreenState();
}

class _DireccionListScreenState extends ConsumerState<DireccionListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _nombreCliente(List<Cliente> clientes, int id) {
    for (final c in clientes) {
      if (c.id == id) return '${c.nombre} ${c.apellido}';
    }
    return 'Cliente #$id';
  }

  Future<void> _confirmarEliminar(int id, String direccionResumen) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar dirección?'),
        content: Text('Vas a eliminar "$direccionResumen". Esta acción no se puede deshacer.'),
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

    final exito = await ref.read(direccionAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Dirección eliminada' : 'No se pudo eliminar la dirección'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final direccionState = ref.watch(direccionProvider);
    final adminState = ref.watch(direccionAdminProvider);
    final clientesAsync = ref.watch(clientesProvider);

    final ciudades = direccionState.direcciones.map((d) => d.ciudad).toSet().toList()..sort();
    final provincias = direccionState.direcciones.map((d) => d.provincia).toSet().toList()..sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Direcciones')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(direccionProvider.notifier).loadDirecciones(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar dirección...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(direccionProvider.notifier).buscar('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) => ref.read(direccionProvider.notifier).buscar(value),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: direccionState.ciudadSeleccionada,
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
                    onChanged: (v) => ref.read(direccionProvider.notifier).filtrarPorCiudad(v),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: direccionState.provinciaSeleccionada,
                    decoration: const InputDecoration(labelText: 'Provincia'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                      ...provincias.map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(p, overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                      ),
                    ],
                    onChanged: (v) => ref.read(direccionProvider.notifier).filtrarPorProvincia(v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text('${direccionState.direcciones.length} resultados', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 12),

            if (direccionState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (direccionState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(direccionState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (direccionState.direcciones.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('No se encontraron direcciones', style: AppTextStyles.bodySecondary)),
              )
            else
              for (final direccion in direccionState.direcciones) ...[
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(
                      clientesAsync.when(
                        data: (clientes) => _nombreCliente(clientes, direccion.cliente),
                        loading: () => 'Cliente #${direccion.cliente}',
                        error: (_, __) => 'Cliente #${direccion.cliente}',
                      ),
                    ),
                    subtitle: Text(
                      '${direccion.calle}, ${direccion.ciudad}, ${direccion.provincia}'
                      '${direccion.principal ? ' · Principal' : ''}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                          onPressed: () =>
                              context.push('/direcciones/${direccion.id}/editar', extra: direccion),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error),
                          onPressed: adminState.isLoading
                              ? null
                              : () => _confirmarEliminar(direccion.id, '${direccion.calle}, ${direccion.ciudad}'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/direcciones/nuevo'),
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
    );
  }
}
