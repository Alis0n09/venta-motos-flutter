// lib/presentation/screens/compra/compra_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/proveedor.dart';
import '../../../domain/model/sucursal.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/compra_provider.dart';
import '../../providers/proveedor_provider.dart';
import '../../providers/sucursal_provider.dart';

class CompraListScreen extends ConsumerWidget {
  const CompraListScreen({super.key});

  String _nombreProveedor(List<Proveedor> proveedores, int id) {
    for (final p in proveedores) {
      if (p.id == id) return p.empresa;
    }
    return 'Proveedor #$id';
  }

  String _nombreSucursal(List<Sucursal> sucursales, int id) {
    for (final s in sucursales) {
      if (s.id == id) return s.nombre;
    }
    return 'Sucursal #$id';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compraState = ref.watch(compraProvider);
    final authState = ref.watch(authProvider);
    final proveedorState = ref.watch(proveedorProvider);
    final sucursalesAsync = ref.watch(sucursalesTodasProvider);
    final puedeGestionar = authState.isAdmin || authState.isBodeguero;

    return Scaffold(
      appBar: AppBar(title: const Text('Compras')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(compraProvider.notifier).loadCompras(),
        child: sucursalesAsync.when(
          data: (sucursales) => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: compraState.proveedorSeleccionado,
                      decoration: const InputDecoration(labelText: 'Proveedor'),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('Todos', overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                        ...proveedorState.proveedores.map(
                          (p) => DropdownMenuItem(
                            value: p.id,
                            child: Text(p.empresa, overflow: TextOverflow.ellipsis, maxLines: 1),
                          ),
                        ),
                      ],
                      onChanged: (v) => ref.read(compraProvider.notifier).filtrarPorProveedor(v),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: compraState.sucursalSeleccionada,
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
                      onChanged: (v) => ref.read(compraProvider.notifier).filtrarPorSucursal(v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text('${compraState.compras.length} resultados', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 12),

              if (compraState.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (compraState.error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: Text(compraState.error!, style: AppTextStyles.bodySecondary)),
                )
              else if (compraState.compras.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: Text('No hay compras registradas', style: AppTextStyles.bodySecondary)),
                )
              else
                for (final compra in compraState.compras) ...[
                  Card(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      title: Text(_nombreProveedor(proveedorState.proveedores, compra.proveedor)),
                      subtitle: Text(
                        '${_nombreSucursal(sucursales, compra.sucursalDestino)} · ${compra.fecha}',
                      ),
                      trailing: Text('\$${compra.total.toStringAsFixed(0)}', style: AppTextStyles.price),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(
            child: Text('No se pudieron cargar las sucursales', style: AppTextStyles.bodySecondary),
          ),
        ),
      ),
      floatingActionButton: puedeGestionar
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/compras/nueva'),
              icon: const Icon(Icons.add),
              label: const Text('Registrar compra'),
            )
          : null,
    );
  }
}
