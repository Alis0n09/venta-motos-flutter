// lib/presentation/screens/proveedor/proveedor_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/proveedor.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/proveedor_admin_provider.dart';

final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class ProveedorFormScreen extends ConsumerStatefulWidget {
  final Proveedor? proveedor;

  const ProveedorFormScreen({super.key, this.proveedor});

  @override
  ConsumerState<ProveedorFormScreen> createState() => _ProveedorFormScreenState();
}

class _ProveedorFormScreenState extends ConsumerState<ProveedorFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _empresaController;
  late final TextEditingController _contactoController;
  late final TextEditingController _correoController;
  late final TextEditingController _paisController;

  bool get _esEdicion => widget.proveedor != null;

  @override
  void initState() {
    super.initState();
    final proveedor = widget.proveedor;
    _empresaController = TextEditingController(text: proveedor?.empresa ?? '');
    _contactoController = TextEditingController(text: proveedor?.contacto ?? '');
    _correoController = TextEditingController(text: proveedor?.correo ?? '');
    _paisController = TextEditingController(text: proveedor?.pais ?? '');
  }

  @override
  void dispose() {
    _empresaController.dispose();
    _contactoController.dispose();
    _correoController.dispose();
    _paisController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'empresa': _empresaController.text.trim(),
      if (_contactoController.text.trim().isNotEmpty) 'contacto': _contactoController.text.trim(),
      if (_correoController.text.trim().isNotEmpty) 'correo': _correoController.text.trim(),
      if (_paisController.text.trim().isNotEmpty) 'pais': _paisController.text.trim(),
    };

    final notifier = ref.read(proveedorAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.proveedor!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(proveedorAdminProvider).error;
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
    final adminState = ref.watch(proveedorAdminProvider);
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
                          _esEdicion ? 'EDITAR PROVEEDOR' : 'NUEVO PROVEEDOR',
                          style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                        ),
                        Text(
                          _esEdicion ? widget.proveedor!.empresa : 'Crear proveedor',
                          style: AppTextStyles.heading2,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('EMPRESA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _empresaController,
                  enabled: !isLoading,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),

                const Text('CONTACTO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _contactoController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Opcional'),
                ),
                const SizedBox(height: 16),

                const Text('CORREO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _correoController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Opcional'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    return _emailRegex.hasMatch(v.trim()) ? null : 'Correo inválido';
                  },
                ),
                const SizedBox(height: 16),

                const Text('PAÍS', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _paisController,
                  enabled: !isLoading,
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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear proveedor'),
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
