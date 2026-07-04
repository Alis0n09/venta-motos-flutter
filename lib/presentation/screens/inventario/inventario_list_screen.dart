// lib/presentation/screens/inventario/inventario_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/inventario_admin_provider.dart';
import '../../providers/inventario_provider.dart';
import '../../providers/sucursal_provider.dart';

class InventarioListScreen extends ConsumerStatefulWidget {
  const InventarioListScreen({super.key});

  @override
  ConsumerState<InventarioListScreen> createState() => _InventarioListScreenState();
}

class _InventarioListScreenState extends ConsumerState<InventarioListScreen> {
  final _searchController = TextEditingController();
  final _cantidadMinController = TextEditingController();
  final _cantidadMaxController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _cantidadMinController.dispose();
    _cantidadMaxController.dispose();
    super.dispose();
  }

  void _aplicarFiltroCantidad() {
    ref.read(inventarioProvider.notifier).filtrarPorCantidad(
          min: int.tryParse(_cantidadMinController.text),
          max: int.tryParse(_cantidadMaxController.text),
        );
  }

  Future<void> _confirmarEliminar(int id, String motoNombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar registro?'),
        content: Text('Vas a eliminar "$motoNombre" de este inventario. Esta acción no se puede deshacer.'),
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

    final exito = await ref.read(inventarioAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Registro eliminado' : 'No se pudo eliminar el registro'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventarioState = ref.watch(inventarioProvider);
    final adminState = ref.watch(inventarioAdminProvider);
    final authState = ref.watch(authProvider);
    final motosAsync = ref.watch(recomendadasProvider);
    final sucursalState = ref.watch(sucursalProvider);
    final puedeGestionar = authState.isAdmin || authState.isBodeguero;

    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(inventarioProvider.notifier).loadInventarios(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por moto o sucursal...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(inventarioProvider.notifier).buscar('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) => ref.read(inventarioProvider.notifier).buscar(value),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: inventarioState.sucursalSeleccionada,
                    decoration: const InputDecoration(labelText: 'Sucursal'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<int>(
                        value: null,
                        child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                      ...sucursalState.sucursales.map(
                        (s) => DropdownMenuItem(
                          value: s.id,
                          child: Text(s.nombre, overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                      ),
                    ],
                    onChanged: (v) => ref.read(inventarioProvider.notifier).filtrarPorSucursal(v),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: motosAsync.when(
                    data: (motos) => DropdownButtonFormField<int>(
                      initialValue: inventarioState.motoSeleccionada,
                      decoration: const InputDecoration(labelText: 'Moto'),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                        ...motos.map(
                          (m) => DropdownMenuItem(
                            value: m.id,
                            child: Text(
                              '${m.marcaNombre} ${m.modelo}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (v) => ref.read(inventarioProvider.notifier).filtrarPorMoto(v),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (_, __) => const Text('Error'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _cantidadMinController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cantidad mín.'),
                    onSubmitted: (_) => _aplicarFiltroCantidad(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _cantidadMaxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cantidad máx.'),
                    onSubmitted: (_) => _aplicarFiltroCantidad(),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Aplicar filtro de cantidad',
                  icon: const Icon(Icons.filter_alt_outlined, color: AppColors.accent),
                  onPressed: _aplicarFiltroCantidad,
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text('${inventarioState.inventarios.length} resultados', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 12),

            if (inventarioState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (inventarioState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(inventarioState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (inventarioState.inventarios.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(
                  child: Text('No se encontraron registros de inventario', style: AppTextStyles.bodySecondary),
                ),
              )
            else
              for (final item in inventarioState.inventarios) ...[
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(item.motoNombre),
                    subtitle: Text(
                      '${item.sucursalNombre} · Cantidad: ${item.cantidad}'
                      '${(item.ubicacionBodega != null && item.ubicacionBodega!.isNotEmpty) ? ' · ${item.ubicacionBodega}' : ''}',
                    ),
                    trailing: puedeGestionar
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                                onPressed: () => context.push('/inventario/${item.id}/editar', extra: item),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: adminState.isLoading
                                    ? null
                                    : () => _confirmarEliminar(item.id, item.motoNombre),
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
              onPressed: () => context.push('/inventario/nuevo'),
              icon: const Icon(Icons.add),
              label: const Text('Agregar'),
            )
          : null,
    );
  }
}
