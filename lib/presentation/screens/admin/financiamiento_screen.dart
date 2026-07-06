// lib/presentation/screens/admin/financiamiento_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/cuota_pago.dart';
import '../../../domain/model/financiamiento.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cuota_pago_admin_provider.dart';
import '../../providers/financiamiento_admin_provider.dart';

class FinanciamientoScreen extends ConsumerStatefulWidget {
  final int ventaId;

  const FinanciamientoScreen({super.key, required this.ventaId});

  @override
  ConsumerState<FinanciamientoScreen> createState() => _FinanciamientoScreenState();
}

class _FinanciamientoScreenState extends ConsumerState<FinanciamientoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _tasaController = TextEditingController();
  final _plazoController = TextEditingController();
  DateTime _fechaInicio = DateTime.now();
  String _estado = 'activo';
  bool _inicializado = false;

  @override
  void dispose() {
    _montoController.dispose();
    _tasaController.dispose();
    _plazoController.dispose();
    super.dispose();
  }

  void _cargarDatos(Financiamiento f) {
    _montoController.text = f.montoFinanciado.toStringAsFixed(2);
    _tasaController.text = f.tasaInteres.toStringAsFixed(2);
    _plazoController.text = f.plazoMeses.toString();
    _fechaInicio = f.fechaInicio;
    _estado = f.estado;
  }

  String _fmtFecha(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _elegirFecha() async {
    final elegida = await showDatePicker(
      context: context,
      initialDate: _fechaInicio,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (elegida != null) setState(() => _fechaInicio = elegida);
  }

  Future<void> _guardar(Financiamiento? existente) async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'venta': widget.ventaId,
      'monto_financiado': double.parse(_montoController.text),
      'tasa_interes': double.parse(_tasaController.text),
      'plazo_meses': int.parse(_plazoController.text),
      'fecha_inicio': _fmtFecha(_fechaInicio),
      'estado': _estado,
    };

    final notifier = ref.read(financiamientoAdminProvider.notifier);

    if (existente == null) {
      final creado = await notifier.crear(payload, ventaId: widget.ventaId);
      if (!mounted) return;
      if (creado != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Financiamiento creado'), backgroundColor: AppColors.success),
        );
      } else {
        final error = ref.read(financiamientoAdminProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error?.toString() ?? 'Error al crear'), backgroundColor: AppColors.error),
        );
      }
    } else {
      final exito = await notifier.editar(existente.id, payload, ventaId: widget.ventaId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Financiamiento actualizado' : (ref.read(financiamientoAdminProvider).error?.toString() ?? 'Error al guardar')),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _confirmarEliminar(Financiamiento f) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar financiamiento?'),
        content: const Text('Se eliminarán también todas sus cuotas. Esta acción no se puede deshacer.'),
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

    final exito = await ref.read(financiamientoAdminProvider.notifier).eliminar(f.id, ventaId: widget.ventaId);
    if (!mounted) return;
    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(financiamientoAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'No se pudo eliminar'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final financiamientoAsync = ref.watch(financiamientoPorVentaProvider(widget.ventaId));
    final adminState = ref.watch(financiamientoAdminProvider);
    final authState = ref.watch(authProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('Financiamiento · Venta #${widget.ventaId}')),
      body: financiamientoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('No se pudo cargar el financiamiento', style: AppTextStyles.bodySecondary)),
        data: (financiamiento) {
          if (!_inicializado) {
            if (financiamiento != null) _cargarDatos(financiamiento);
            _inicializado = true;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (financiamiento != null && financiamiento.clienteNombre != null) ...[
                  Text('CLIENTE', style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  Text(financiamiento.clienteNombre!, style: AppTextStyles.heading2),
                  if (financiamiento.motoDetalle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(financiamiento.motoDetalle.join(', '), style: AppTextStyles.bodySecondary),
                  ],
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                ],
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MONTO FINANCIADO', style: AppTextStyles.caption),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _montoController,
                        enabled: !isLoading,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(prefixText: '\$ '),
                        validator: (v) {
                          final n = double.tryParse(v ?? '');
                          if (n == null || n <= 0) return 'Ingresa un monto válido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Text('TASA DE INTERÉS ANUAL (%)', style: AppTextStyles.caption),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _tasaController,
                        enabled: !isLoading,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(suffixText: '%'),
                        validator: (v) {
                          final n = double.tryParse(v ?? '');
                          if (n == null || n < 0) return 'Ingresa una tasa válida';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Text('PLAZO (MESES)', style: AppTextStyles.caption),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _plazoController,
                        enabled: !isLoading,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          final n = int.tryParse(v ?? '');
                          if (n == null || n <= 0) return 'Ingresa un plazo válido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Text('FECHA DE INICIO', style: AppTextStyles.caption),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: isLoading ? null : _elegirFecha,
                        child: InputDecorator(
                          decoration: const InputDecoration(),
                          child: Text(DateFormat('dd/MM/yyyy').format(_fechaInicio)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text('ESTADO', style: AppTextStyles.caption),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _estado,
                        items: const [
                          DropdownMenuItem(value: 'activo', child: Text('Activo')),
                          DropdownMenuItem(value: 'pagado', child: Text('Pagado')),
                          DropdownMenuItem(value: 'cancelado', child: Text('Cancelado')),
                        ],
                        onChanged: isLoading ? null : (v) => setState(() => _estado = v!),
                      ),

                      if (financiamiento?.cuotaMensual != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cuota mensual estimada', style: AppTextStyles.bodySecondary),
                              Text('\$${financiamiento!.cuotaMensual!.toStringAsFixed(2)}', style: AppTextStyles.price),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 28),

                      if (financiamiento != null && authState.isAdmin)
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: isLoading ? null : () => _confirmarEliminar(financiamiento),
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
                                onPressed: isLoading ? null : () => _guardar(financiamiento),
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
                            onPressed: isLoading ? null : () => _guardar(financiamiento),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : Text(financiamiento == null ? 'Crear financiamiento' : 'Guardar cambios'),
                          ),
                        ),
                    ],
                  ),
                ),

                if (financiamiento != null) ...[
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),
                  _CuotasSection(financiamiento: financiamiento),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CuotasSection extends ConsumerWidget {
  final Financiamiento financiamiento;

  const _CuotasSection({required this.financiamiento});

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'pagada':
        return AppColors.success;
      case 'vencida':
        return AppColors.error;
      case 'cancelada':
        return AppColors.textSecondary;
      default:
        return AppColors.warning;
    }
  }

  Future<void> _confirmarEliminar(BuildContext context, WidgetRef ref, CuotaPago cuota) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¿Eliminar cuota #${cuota.numeroCuota}?'),
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

    final exito = await ref
        .read(cuotaPagoAdminProvider.notifier)
        .eliminar(cuota.id, financiamientoId: financiamiento.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Cuota eliminada' : 'No se pudo eliminar la cuota'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _marcarPagada(BuildContext context, WidgetRef ref, CuotaPago cuota) async {
    final exito = await ref
        .read(cuotaPagoAdminProvider.notifier)
        .marcarPagada(cuota, financiamientoId: financiamiento.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Cuota marcada como pagada' : 'No se pudo actualizar la cuota'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cuotasAsync = ref.watch(cuotasPorFinanciamientoProvider(financiamiento.id));
    final cuotaState = ref.watch(cuotaPagoAdminProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('CUOTAS', style: AppTextStyles.caption),
            TextButton.icon(
              onPressed: () => context.push(
                '/admin/cuotas/crear',
                extra: {'financiamientoId': financiamiento.id},
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Agregar cuota'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        cuotasAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Text('No se pudieron cargar las cuotas', style: AppTextStyles.bodySecondary),
          data: (cuotas) => cuotas.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('Aún no hay cuotas registradas', style: AppTextStyles.bodySecondary),
                )
              : Column(
                  children: [
                    for (final cuota in cuotas)
                      Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          onTap: () => context.push(
                            '/admin/cuotas/editar',
                            extra: {'financiamientoId': financiamiento.id, 'cuota': cuota},
                          ),
                          title: Text('Cuota #${cuota.numeroCuota} · \$${cuota.monto.toStringAsFixed(2)}'),
                          subtitle: Text(
                            'Vence ${DateFormat('dd/MM/yyyy').format(cuota.fechaVencimiento)}'
                            '${cuota.fechaPago != null ? ' · Pagada ${DateFormat('dd/MM/yyyy').format(cuota.fechaPago!)}' : ''}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: _colorEstado(cuota.estado).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  cuota.estado,
                                  style: TextStyle(
                                    color: _colorEstado(cuota.estado),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (cuota.estado == 'pendiente' || cuota.estado == 'vencida')
                                IconButton(
                                  tooltip: 'Marcar como pagada',
                                  icon: const Icon(Icons.check_circle_outline, color: AppColors.success),
                                  onPressed: cuotaState.isLoading ? null : () => _marcarPagada(context, ref, cuota),
                                ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: cuotaState.isLoading ? null : () => _confirmarEliminar(context, ref, cuota),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}