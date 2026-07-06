// lib/presentation/screens/admin/categoria_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/categoria.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/categoria_admin_provider.dart';

class CategoriaFormScreen extends ConsumerStatefulWidget {
  final Categoria? categoria;

  const CategoriaFormScreen({super.key, this.categoria});

  @override
  ConsumerState<CategoriaFormScreen> createState() => _CategoriaFormScreenState();
}

class _CategoriaFormScreenState extends ConsumerState<CategoriaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _descripcionController;

  bool get _esEdicion => widget.categoria != null;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.categoria?.nombre ?? '');
    _descripcionController = TextEditingController(text: widget.categoria?.descripcion ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'nombre': _nombreController.text.trim(),
      'descripcion': _descripcionController.text.trim(),
    };

    final notifier = ref.read(categoriaAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.categoria!.id, payload)
        : await notifier.crear(payload);

    if (!mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(categoriaAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(categoriaAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar categoría' : 'Nueva categoría')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NOMBRE', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nombreController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Naked, Scooter, Enduro...'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa el nombre' : null,
                ),
                const SizedBox(height: 16),

                Text('DESCRIPCIÓN', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _descripcionController,
                  enabled: !isLoading,
                  maxLines: 3,
                  decoration: const InputDecoration(hintText: 'Descripción opcional'),
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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear categoría'),
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
