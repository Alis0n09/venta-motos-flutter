// lib/presentation/screens/mantenimiento/mantenimiento_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/mantenimiento.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/mantenimiento_provider.dart';

class MantenimientoScreen extends ConsumerWidget {
  const MantenimientoScreen({super.key});

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, int id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar registro?'),
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

    final exito = await ref.read(mantenimientoFormProvider.notifier).eliminar(id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Eliminado' : 'No se pudo eliminar'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _abrirFormulario(
    BuildContext context,
    WidgetRef ref, {
    required bool esStaff,
    Mantenimiento? existente,
  }) async {
    final esEdicion = existente != null;

    int? motoSeleccionada = existente?.moto;
    int? clienteSeleccionado = existente?.cliente;
    final tipoController = TextEditingController(text: existente?.tipo ?? '');
    final costoController = TextEditingController(text: existente?.costo.toString() ?? '0');
    DateTime? fecha = existente?.fecha;
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final isLoading = ref.watch(mantenimientoFormProvider).isLoading;

          return AlertDialog(
            title: Text(esEdicion ? 'Editar mantenimiento' : 'Agendar mantenimiento'),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, _) {
                        final motosAsync = ref.watch(recomendadasProvider);
                        return motosAsync.when(
                          loading: () => const LinearProgressIndicator(),
                          error: (_, __) => const Text('No se pudieron cargar las motos'),
                          data: (motos) => DropdownButtonFormField<int>(
                            initialValue: motoSeleccionada,
                            hint: const Text('Selecciona una moto'),
                            items: motos
                                .map((m) => DropdownMenuItem(
                                      value: m.id,
                                      child: Text('${m.marcaNombre} ${m.modelo}'),
                                    ))
                                .toList(),
                            onChanged: isLoading ? null : (v) => setDialogState(() => motoSeleccionada = v),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    if (esStaff) ...[
                      // ── Cliente (reactivo de verdad con Consumer) ──
                      Consumer(
                        builder: (context, ref, _) {
                          final clientesAsync = ref.watch(clientesMiniProvider);
                          return clientesAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (_, __) => const Text('No se pudieron cargar los clientes'),
                            data: (clientes) => DropdownButtonFormField<int>(
                              initialValue: clienteSeleccionado,
                              hint: const Text('Selecciona un cliente'),
                              items: clientes
                                  .map((c) => DropdownMenuItem(value: c.id, child: Text(c.nombreCompleto)))
                                  .toList(),
                              onChanged: isLoading ? null : (v) => setDialogState(() => clienteSeleccionado = v),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                    ],

                    TextFormField(
                      controller: tipoController,
                      enabled: !isLoading,
                      decoration: const InputDecoration(labelText: 'Tipo (ej: Cambio de aceite)'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              final elegida = await showDatePicker(
                                context: context,
                                initialDate: fecha ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2035),
                              );
                              if (elegida != null) setDialogState(() => fecha = elegida);
                            },
                      child: Text(fecha != null ? DateFormat('dd/MM/yyyy').format(fecha!) : 'Elegir fecha'),
                    ),
                    const SizedBox(height: 12),

                    if (esStaff)
                      TextFormField(
                        controller: costoController,
                        enabled: !isLoading,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: 'Costo', prefixText: '\$ '),
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        if (motoSeleccionada == null || fecha == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Completa moto y fecha'), backgroundColor: AppColors.error),
                          );
                          return;
                        }
                        if (esStaff && clienteSeleccionado == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Selecciona un cliente'), backgroundColor: AppColors.error),
                          );
                          return;
                        }

                        final payload = {
                          'moto': motoSeleccionada,
                          if (esStaff) 'cliente': clienteSeleccionado,
                          'fecha': DateFormat('yyyy-MM-dd').format(fecha!),
                          'tipo': tipoController.text.trim(),
                          'costo': double.tryParse(costoController.text) ?? 0,
                        };

                        final notifier = ref.read(mantenimientoFormProvider.notifier);
                        final exito = esEdicion
                            ? await notifier.editar(existente.id, payload)
                            : await notifier.crear(payload);

                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(exito
                                  ? (esEdicion ? 'Actualizado' : 'Mantenimiento agendado')
                                  : 'No se pudo guardar'),
                              backgroundColor: exito ? AppColors.success : AppColors.error,
                            ),
                          );
                        }
                      },
                child: isLoading
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Guardar'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final mantenimientosAsync = ref.watch(mantenimientosProvider);
    final esStaff = authState.isStaff;

    return Scaffold(
      appBar: AppBar(title: const Text('Mantenimientos')),
      body: mantenimientosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('No se pudieron cargar los mantenimientos')),
        data: (mantenimientos) {
          if (mantenimientos.isEmpty) {
            return Center(
              child: Text(
                esStaff ? 'No hay mantenimientos registrados' : 'Aún no tienes mantenimientos agendados',
                style: AppTextStyles.bodySecondary,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: mantenimientos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final m = mantenimientos[index];
              return Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.accentLight,
                    child: Icon(Icons.build, color: AppColors.accent),
                  ),
                  title: Text(m.tipo),
                  subtitle: Text(
                    '${m.motoDetalle ?? 'Moto'} · ${DateFormat('dd/MM/yyyy').format(m.fecha)}'
                    '${esStaff && m.clienteNombre != null ? ' · ${m.clienteNombre}' : ''}',
                  ),
                  onTap: esStaff ? () => _abrirFormulario(context, ref, esStaff: true, existente: m) : null,
                  trailing: esStaff
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$${m.costo.toStringAsFixed(0)}', style: AppTextStyles.body),
                            if (authState.isAdmin)
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                                onPressed: () => _confirmarEliminar(context, ref, m.id),
                              ),
                          ],
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(context, ref, esStaff: esStaff),
        icon: const Icon(Icons.add),
        label: Text(esStaff ? 'Nuevo registro' : 'Agendar'),
      ),
    );
  }
}