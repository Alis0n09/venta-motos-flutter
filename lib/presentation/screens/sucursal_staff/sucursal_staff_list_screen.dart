// lib/presentation/screens/sucursal_staff/sucursal_staff_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/sucursal_provider.dart';
import '../../providers/sucursal_staff_admin_provider.dart';
import '../../providers/sucursal_staff_provider.dart';

class SucursalStaffListScreen extends ConsumerStatefulWidget {
  const SucursalStaffListScreen({super.key});

  @override
  ConsumerState<SucursalStaffListScreen> createState() => _SucursalStaffListScreenState();
}

class _SucursalStaffListScreenState extends ConsumerState<SucursalStaffListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmarEliminar(int id, String staffNombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar asignación?'),
        content: Text('Vas a quitar a "$staffNombre" de esa sucursal. Esta acción no se puede deshacer.'),
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

    final exito = await ref.read(sucursalStaffAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Asignación eliminada' : 'No se pudo eliminar la asignación'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  String _formatearFecha(String fechaIso) {
    final fecha = DateTime.tryParse(fechaIso);
    if (fecha == null) return fechaIso;
    final local = fecha.toLocal();
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${dos(local.day)}/${dos(local.month)}/${local.year}';
  }

  @override
  Widget build(BuildContext context) {
    final staffState = ref.watch(sucursalStaffProvider);
    final adminState = ref.watch(sucursalStaffAdminProvider);
    final sucursalesAsync = ref.watch(sucursalesTodasProvider);

    final busqueda = _searchController.text.trim().toLowerCase();
    final asignacionesFiltradas = busqueda.isEmpty
        ? staffState.asignaciones
        : staffState.asignaciones
            .where((a) =>
                a.staffNombre.toLowerCase().contains(busqueda) ||
                a.sucursalNombre.toLowerCase().contains(busqueda))
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Asignaciones de staff')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(sucursalStaffProvider.notifier).loadAsignaciones(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por empleado o sucursal...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            sucursalesAsync.when(
              data: (sucursales) => DropdownButtonFormField<int>(
                initialValue: staffState.sucursalSeleccionada,
                decoration: const InputDecoration(labelText: 'Sucursal'),
                isExpanded: true,
                items: [
                  const DropdownMenuItem<int>(
                    value: null,
                    child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                  ...sucursales.map(
                    (s) => DropdownMenuItem(
                      value: s.id,
                      child: Text(s.nombre, overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                  ),
                ],
                onChanged: (v) => ref.read(sucursalStaffProvider.notifier).filtrarPorSucursal(v),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('No se pudieron cargar las sucursales'),
            ),
            const SizedBox(height: 20),

            Text('${asignacionesFiltradas.length} resultados', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 12),

            if (staffState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (staffState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(staffState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (asignacionesFiltradas.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('No se encontraron asignaciones', style: AppTextStyles.bodySecondary)),
              )
            else
              for (final asignacion in asignacionesFiltradas) ...[
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(asignacion.staffNombre),
                    subtitle: Text(
                      '${asignacion.sucursalNombre} · desde ${_formatearFecha(asignacion.fechaAsignacion)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                          onPressed: () =>
                              context.push('/sucursal-staff/${asignacion.id}/editar', extra: asignacion),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error),
                          onPressed: adminState.isLoading
                              ? null
                              : () => _confirmarEliminar(asignacion.id, asignacion.staffNombre),
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
        onPressed: () => context.push('/sucursal-staff/nuevo'),
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
    );
  }
}
