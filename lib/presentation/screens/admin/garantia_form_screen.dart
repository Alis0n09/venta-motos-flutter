// lib/presentation/screens/admin/garantia_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/garantia.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/garantia_admin_provider.dart';
import '../../providers/venta_admin_provider.dart';

class GarantiaFormScreen extends ConsumerStatefulWidget {
  final Garantia? garantia;

  const GarantiaFormScreen({super.key, this.garantia});

  @override
  ConsumerState<GarantiaFormScreen> createState() => _GarantiaFormScreenState();
}

class _GarantiaFormScreenState extends ConsumerState<GarantiaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tipoController;

  int? _ventaSeleccionada;
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  bool get _esEdicion => widget.garantia != null;

  @override
  void initState() {
    super.initState();
    final garantia = widget.garantia;
    _tipoController = TextEditingController(text: garantia?.tipo ?? '');
    _ventaSeleccionada = garantia?.venta;
    _fechaInicio = garantia?.fechaInicio;
    _fechaFin = garantia?.fechaFin;
  }

  @override
  void dispose() {
    _tipoController.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha({required bool esInicio}) async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: (esInicio ? _fechaInicio : _fechaFin) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (fecha == null) return;
    setState(() {
      if (esInicio) {
        _fechaInicio = fecha;
      } else {
        _fechaFin = fecha;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_ventaSeleccionada == null || _fechaInicio == null || _fechaFin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa venta, fecha inicio y fecha fin'), backgroundColor: AppColors.error),
      );
      return;
    }
    if (_fechaFin!.isBefore(_fechaInicio!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La fecha de fin no puede ser anterior al inicio'), backgroundColor: AppColors.error),
      );
      return;
    }

    final payload = {
      'venta': _ventaSeleccionada,
      'fecha_inicio': DateFormat('yyyy-MM-dd').format(_fechaInicio!),
      'fecha_fin': DateFormat('yyyy-MM-dd').format(_fechaFin!),
      'tipo': _tipoController.text.trim(),
    };

    final notifier = ref.read(garantiaAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.garantia!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;
    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(garantiaAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ventasAsync = ref.watch(ventasAdminProvider);
    final adminState = ref.watch(garantiaAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar garantía' : 'Nueva garantía')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('VENTA', style: AppTextStyles.caption),
              const SizedBox(height: 6),
              ventasAsync.when(
                data: (ventas) => DropdownButtonFormField<int>(
                  initialValue: _ventaSeleccionada,
                  hint: const Text('Selecciona una venta'),
                  items: ventas
                      .map((v) => DropdownMenuItem(
                            value: v.id,
                            child: Text('#${v.id} · ${v.clienteNombre ?? 'Cliente'} · \$${v.total.toStringAsFixed(0)}'),
                          ))
                      .toList(),
                  onChanged: isLoading ? null : (v) => setState(() => _ventaSeleccionada = v),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('No se pudieron cargar las ventas'),
              ),
              const SizedBox(height: 16),

              Text('TIPO DE GARANTÍA', style: AppTextStyles.caption),
              const SizedBox(height: 6),
              TextFormField(
                controller: _tipoController,
                enabled: !isLoading,
                decoration: const InputDecoration(hintText: 'Ej: Motor, General, Extendida...'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa el tipo' : null,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('FECHA INICIO', style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        OutlinedButton(
                          onPressed: isLoading ? null : () => _elegirFecha(esInicio: true),
                          child: Text(
                            _fechaInicio != null ? DateFormat('dd/MM/yyyy').format(_fechaInicio!) : 'Elegir',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('FECHA FIN', style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        OutlinedButton(
                          onPressed: isLoading ? null : () => _elegirFecha(esInicio: false),
                          child: Text(
                            _fechaFin != null ? DateFormat('dd/MM/yyyy').format(_fechaFin!) : 'Elegir',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_esEdicion ? 'Guardar cambios' : 'Crear garantía'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}