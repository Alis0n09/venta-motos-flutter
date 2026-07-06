// lib/presentation/screens/admin/venta_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/venta_admin_provider.dart';

class VentaFormScreen extends ConsumerStatefulWidget {
  final int ventaId;

  const VentaFormScreen({super.key, required this.ventaId});

  @override
  ConsumerState<VentaFormScreen> createState() => _VentaFormScreenState();
}

class _VentaFormScreenState extends ConsumerState<VentaFormScreen> {
  String? _metodoPago;
  int? _vendedorSeleccionado;
  bool _inicializado = false;

  Future<void> _submit() async {
    final payload = {
      if (_metodoPago != null) 'metodo_pago': _metodoPago,
      'vendedor': _vendedorSeleccionado,
    };

    final exito = await ref.read(ventaAdminProvider.notifier).editar(widget.ventaId, payload);

    if (!mounted) return;

    if (exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Venta actualizada'), backgroundColor: AppColors.success),
      );
      Navigator.of(context).pop();
    } else {
      final error = ref.read(ventaAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  Future<void> _confirmarEliminar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar venta?'),
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
    if (confirmar != true || !mounted) return;

    final exito = await ref.read(ventaAdminProvider.notifier).eliminar(widget.ventaId);
    if (!mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(ventaAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'No se pudo eliminar la venta'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ventaAsync = ref.watch(ventaDetalleProvider(widget.ventaId));
    final vendedoresAsync = ref.watch(vendedoresParaVentaProvider);
    final adminState = ref.watch(ventaAdminProvider);
    final authState = ref.watch(authProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('Venta #${widget.ventaId}')),
      body: ventaAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('No se pudo cargar la venta', style: AppTextStyles.bodySecondary),
        ),
        data: (venta) {
          if (!_inicializado) {
            _metodoPago = venta.metodoPago;
            _vendedorSeleccionado = venta.vendedorId;
            _inicializado = true;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CLIENTE', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(venta.clienteNombre, style: AppTextStyles.heading2),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(venta.fechaVenta),
                  style: AppTextStyles.bodySecondary,
                ),

                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                Text('DETALLE DE LA VENTA', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                for (final detalle in venta.detalles)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('${detalle.cantidad}x ${detalle.motoNombre}')),
                        Text('\$${detalle.subtotal.toStringAsFixed(0)}'),
                      ],
                    ),
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppTextStyles.heading2),
                    Text('\$${venta.total.toStringAsFixed(0)}', style: AppTextStyles.price.copyWith(fontSize: 20)),
                  ],
                ),

                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                Text('MÉTODO DE PAGO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _metodoPago,
                  items: const [
                    DropdownMenuItem(value: 'efectivo', child: Text('Efectivo')),
                    DropdownMenuItem(value: 'transferencia', child: Text('Transferencia')),
                    DropdownMenuItem(value: 'tarjeta', child: Text('Tarjeta')),
                    DropdownMenuItem(value: 'credito', child: Text('Crédito')),
                  ],
                  onChanged: isLoading ? null : (v) => setState(() => _metodoPago = v),
                ),

                const SizedBox(height: 16),

                Text('VENDEDOR', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                vendedoresAsync.when(
                  data: (vendedores) {
                    // Si el vendedor asignado ya no existe en la lista (fue desactivado,
                    // eliminado, o simplemente no llegó en la página cargada), el dropdown
                    // no puede usarlo como valor inicial o Flutter truena con un assert.
                    // Por eso se valida que exista antes de usarlo.
                    final idsDisponibles = vendedores.map((v) => v.id).toSet();
                    final valorSeguro = idsDisponibles.contains(_vendedorSeleccionado)
                        ? _vendedorSeleccionado
                        : null;

                    return DropdownButtonFormField<int>(
                      initialValue: valorSeguro,
                      hint: const Text('Sin asignar'),
                      items: vendedores
                          .map((v) => DropdownMenuItem(
                                value: v.id,
                                child: Text('${v.nombre} ${v.apellido} (${v.rol})'),
                              ))
                          .toList(),
                      onChanged: isLoading ? null : (v) => setState(() => _vendedorSeleccionado = v),
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('No se pudieron cargar los vendedores'),
                ),

                const SizedBox(height: 32),

                if (authState.isAdmin)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading ? null : _confirmarEliminar,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: AppColors.border),
                          ),
                          child: const Text('Eliminar', style: TextStyle(color: AppColors.textPrimary)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submit,
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Text('Guardar cambios'),
                        ),
                      ),
                    ],
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Guardar cambios'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}