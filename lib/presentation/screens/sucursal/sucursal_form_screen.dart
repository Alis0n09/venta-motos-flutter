// lib/presentation/screens/sucursal/sucursal_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/sucursal.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/sucursal_admin_provider.dart';

class SucursalFormScreen extends ConsumerStatefulWidget {
  final Sucursal? sucursal;

  const SucursalFormScreen({super.key, this.sucursal});

  @override
  ConsumerState<SucursalFormScreen> createState() => _SucursalFormScreenState();
}

class _SucursalFormScreenState extends ConsumerState<SucursalFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nombreController;
  late final TextEditingController _direccionController;
  late final TextEditingController _ciudadController;
  late final TextEditingController _telefonoController;

  bool get _esEdicion => widget.sucursal != null;

  @override
  void initState() {
    super.initState();
    final sucursal = widget.sucursal;
    _nombreController = TextEditingController(text: sucursal?.nombre ?? '');
    _direccionController = TextEditingController(text: sucursal?.direccion ?? '');
    _ciudadController = TextEditingController(text: sucursal?.ciudad ?? '');
    _telefonoController = TextEditingController(text: sucursal?.telefono ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _ciudadController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'nombre': _nombreController.text.trim(),
      'direccion': _direccionController.text.trim(),
      'ciudad': _ciudadController.text.trim(),
      if (_telefonoController.text.trim().isNotEmpty) 'telefono': _telefonoController.text.trim(),
    };

    final notifier = ref.read(sucursalAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.sucursal!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(sucursalAdminProvider).error;
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
    final adminState = ref.watch(sucursalAdminProvider);
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
                          _esEdicion ? 'EDITAR SUCURSAL' : 'NUEVA SUCURSAL',
                          style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                        ),
                        Text(
                          _esEdicion ? widget.sucursal!.nombre : 'Crear sucursal',
                          style: AppTextStyles.heading2,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('NOMBRE', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nombreController,
                  enabled: !isLoading,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),

                const Text('DIRECCIÓN', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _direccionController,
                  enabled: !isLoading,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),

                const Text('CIUDAD', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _ciudadController,
                  enabled: !isLoading,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),

                const Text('TELÉFONO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _telefonoController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Opcional'),
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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear sucursal'),
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
