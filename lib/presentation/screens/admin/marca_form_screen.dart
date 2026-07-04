// lib/presentation/screens/admin/marca_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/marca.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/marca_admin_provider.dart';

class MarcaFormScreen extends ConsumerStatefulWidget {
  final Marca? marca;

  const MarcaFormScreen({super.key, this.marca});

  @override
  ConsumerState<MarcaFormScreen> createState() => _MarcaFormScreenState();
}

class _MarcaFormScreenState extends ConsumerState<MarcaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _paisController;
  bool _activa = true;

  bool get _esEdicion => widget.marca != null;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.marca?.nombre ?? '');
    _paisController = TextEditingController(text: widget.marca?.paisOrigen ?? '');
    _activa = widget.marca?.activa ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _paisController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'nombre': _nombreController.text.trim(),
      'pais_origen': _paisController.text.trim(),
      'activa': _activa,
    };

    final notifier = ref.read(marcaAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.marca!.id, payload)
        : await notifier.crear(payload);

    if (!mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(marcaAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(marcaAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar marca' : 'Nueva marca')),
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
                  decoration: const InputDecoration(hintText: 'Yamaha, Honda...'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa el nombre' : null,
                ),
                const SizedBox(height: 16),

                Text('PAÍS DE ORIGEN', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _paisController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Japón, Estados Unidos...'),
                ),
                const SizedBox(height: 16),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Activa'),
                  subtitle: const Text('Las marcas inactivas no aparecen en el catálogo'),
                  value: _activa,
                  onChanged: isLoading ? null : (v) => setState(() => _activa = v),
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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear marca'),
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
