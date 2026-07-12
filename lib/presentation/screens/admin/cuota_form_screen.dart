// lib/presentation/screens/admin/cuota_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/cuota_pago.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/cuota_pago_admin_provider.dart';

class CuotaFormScreen extends ConsumerStatefulWidget {
  final int financiamientoId;
  final CuotaPago? cuota;

  const CuotaFormScreen({super.key, required this.financiamientoId, this.cuota});

  @override
  ConsumerState<CuotaFormScreen> createState() => _CuotaFormScreenState();
}

class _CuotaFormScreenState extends ConsumerState<CuotaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _numeroController;
  late final TextEditingController _montoController;
  DateTime _fechaVencimiento = DateTime.now();
  DateTime? _fechaPago;
  late String _estado;

  bool get _esEdicion => widget.cuota != null;

  @override
  void initState() {
    super.initState();
    _numeroController = TextEditingController(text: widget.cuota?.numeroCuota.toString() ?? '');
    _montoController = TextEditingController(text: widget.cuota?.monto.toStringAsFixed(2) ?? '');
    _fechaVencimiento = widget.cuota?.fechaVencimiento ?? DateTime.now();
    _fechaPago = widget.cuota?.fechaPago;
    _estado = widget.cuota?.estado ?? 'pendiente';
  }

  @override
  void dispose() {
    _numeroController.dispose();
    _montoController.dispose();
    super.dispose();
  }

  String _fmtFecha(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _elegirFecha({required bool esVencimiento}) async {
    final elegida = await showDatePicker(
      context: context,
      initialDate: esVencimiento ? _fechaVencimiento : (_fechaPago ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (elegida == null) return;
    setState(() {
      if (esVencimiento) {
        _fechaVencimiento = elegida;
      } else {
        _fechaPago = elegida;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'financiamiento': widget.financiamientoId,
      'numero_cuota': int.parse(_numeroController.text),
      'monto': double.parse(_montoController.text),
      'fecha_vencimiento': _fmtFecha(_fechaVencimiento),
      'fecha_pago': _fechaPago != null ? _fmtFecha(_fechaPago!) : null,
      'estado': _estado,
    };

    final notifier = ref.read(cuotaPagoAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.cuota!.id, payload, financiamientoId: widget.financiamientoId)
        : await notifier.crear(payload, financiamientoId: widget.financiamientoId);

    if (!mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(cuotaPagoAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(cuotaPagoAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar cuota' : 'Nueva cuota')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NÚMERO DE CUOTA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _numeroController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    if (n == null || n <= 0) return 'Ingresa un número válido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Text('MONTO', style: AppTextStyles.caption),
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

                Text('FECHA DE VENCIMIENTO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                InkWell(
                  onTap: isLoading ? null : () => _elegirFecha(esVencimiento: true),
                  child: InputDecorator(
                    decoration: const InputDecoration(),
                    child: Text(DateFormat('dd/MM/yyyy').format(_fechaVencimiento)),
                  ),
                ),
                const SizedBox(height: 16),

                Text('ESTADO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _estado,
                  items: const [
                    DropdownMenuItem(value: 'pendiente', child: Text('Pendiente')),
                    DropdownMenuItem(value: 'pagada', child: Text('Pagada')),
                    DropdownMenuItem(value: 'vencida', child: Text('Vencida')),
                    DropdownMenuItem(value: 'cancelada', child: Text('Cancelada')),
                  ],
                  onChanged: isLoading ? null : (v) => setState(() => _estado = v!),
                ),
                const SizedBox(height: 16),

                Text('FECHA DE PAGO (opcional)', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                InkWell(
                  onTap: isLoading ? null : () => _elegirFecha(esVencimiento: false),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      suffixIcon: _fechaPago != null
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: isLoading ? null : () => setState(() => _fechaPago = null),
                            )
                          : null,
                    ),
                    child: Text(
                      _fechaPago != null ? DateFormat('dd/MM/yyyy').format(_fechaPago!) : 'Sin registrar',
                    ),
                  ),
                ),

                const SizedBox(height: 32),

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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear cuota'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}