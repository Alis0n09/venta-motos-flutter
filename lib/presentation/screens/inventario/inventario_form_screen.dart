// lib/presentation/screens/inventario/inventario_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/inventario.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/inventario_admin_provider.dart';
import '../../providers/sucursal_provider.dart';

class InventarioFormScreen extends ConsumerStatefulWidget {
  final Inventario? inventario;
  // Preselecciona la moto en modo creación (ej. al agregar stock en una
  // sucursal nueva desde el desglose de una moto). Se ignora en modo edición.
  final int? motoPreseleccionada;

  const InventarioFormScreen({super.key, this.inventario, this.motoPreseleccionada});

  @override
  ConsumerState<InventarioFormScreen> createState() => _InventarioFormScreenState();
}

class _InventarioFormScreenState extends ConsumerState<InventarioFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _cantidadController;
  late final TextEditingController _ubicacionBodegaController;

  int? _motoSeleccionada;
  int? _sucursalSeleccionada;

  bool get _esEdicion => widget.inventario != null;

  @override
  void initState() {
    super.initState();
    final inventario = widget.inventario;
    _cantidadController = TextEditingController(text: inventario?.cantidad.toString() ?? '');
    _ubicacionBodegaController = TextEditingController(text: inventario?.ubicacionBodega ?? '');
    _motoSeleccionada = inventario?.moto ?? widget.motoPreseleccionada;
    _sucursalSeleccionada = inventario?.sucursal;
  }

  @override
  void dispose() {
    _cantidadController.dispose();
    _ubicacionBodegaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_motoSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una moto'), backgroundColor: AppColors.error),
      );
      return;
    }
    if (_sucursalSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una sucursal'), backgroundColor: AppColors.error),
      );
      return;
    }

    final payload = {
      'moto': _motoSeleccionada,
      'sucursal': _sucursalSeleccionada,
      'cantidad': int.parse(_cantidadController.text),
      if (_ubicacionBodegaController.text.trim().isNotEmpty)
        'ubicacion_bodega': _ubicacionBodegaController.text.trim(),
    };

    final notifier = ref.read(inventarioAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.inventario!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(inventarioAdminProvider).error;
      final mensaje = (error is ApiException && error.statusCode == 403)
          ? 'No tienes permisos para esta acción'
          : (error?.toString() ?? 'Error al guardar');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final motosAsync = ref.watch(recomendadasProvider);
    final sucursalState = ref.watch(sucursalProvider);
    final adminState = ref.watch(inventarioAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _esEdicion ? 'EDITAR INVENTARIO' : 'NUEVO INVENTARIO',
                          style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                        ),
                        Text(
                          _esEdicion ? widget.inventario!.motoNombre : 'Crear registro',
                          style: AppTextStyles.heading2,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('MOTO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                motosAsync.when(
                  data: (motos) => DropdownButtonFormField<int>(
                    initialValue: _motoSeleccionada,
                    hint: const Text('Elegir'),
                    isExpanded: true,
                    items: motos
                        .map((m) => DropdownMenuItem(
                              value: m.id,
                              child: Text(
                                '${m.marcaNombre} ${m.modelo}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ))
                        .toList(),
                    onChanged: isLoading ? null : (v) => setState(() => _motoSeleccionada = v),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('No se pudieron cargar las motos'),
                ),
                const SizedBox(height: 16),

                const Text('SUCURSAL', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                DropdownButtonFormField<int>(
                  initialValue: _sucursalSeleccionada,
                  hint: const Text('Elegir'),
                  isExpanded: true,
                  items: sucursalState.sucursales
                      .map((s) => DropdownMenuItem(
                            value: s.id,
                            child: Text(s.nombre, overflow: TextOverflow.ellipsis, maxLines: 1),
                          ))
                      .toList(),
                  onChanged: isLoading ? null : (v) => setState(() => _sucursalSeleccionada = v),
                ),
                const SizedBox(height: 16),

                const Text('CANTIDAD', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _cantidadController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Requerido';
                    final n = int.tryParse(v);
                    if (n == null || n < 0) return 'Debe ser un entero mayor o igual a 0';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                const Text('UBICACIÓN EN BODEGA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _ubicacionBodegaController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Opcional, ej. Estante A-3'),
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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear registro'),
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
