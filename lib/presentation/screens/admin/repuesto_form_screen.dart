import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/repuesto.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/repuesto_admin_provider.dart';

class RepuestoFormScreen extends ConsumerStatefulWidget {
  final Repuesto? repuesto;

  const RepuestoFormScreen({super.key, this.repuesto});

  @override
  ConsumerState<RepuestoFormScreen> createState() => _RepuestoFormScreenState();
}

class _RepuestoFormScreenState extends ConsumerState<RepuestoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _stockController;
  late final TextEditingController _precioController;

  int? _marcaSeleccionada;

  bool get _esEdicion => widget.repuesto != null;

  @override
  void initState() {
    super.initState();
    final r = widget.repuesto;
    _nombreController = TextEditingController(text: r?.nombre ?? '');
    _stockController = TextEditingController(text: r?.stock.toString() ?? '0');
    _precioController = TextEditingController(text: r?.precio.toString() ?? '');
    _marcaSeleccionada = r?.marcaCompatible;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _stockController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'nombre': _nombreController.text.trim(),
      if (_marcaSeleccionada != null) 'marca_compatible': _marcaSeleccionada,
      'stock': int.parse(_stockController.text),
      'precio': double.parse(_precioController.text),
    };

    final notifier = ref.read(repuestoAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.repuesto!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;
    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(repuestoAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final marcasAsync = ref.watch(marcasProvider);
    final adminState = ref.watch(repuestoAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar repuesto' : 'Nuevo repuesto')),
      body: SingleChildScrollView(
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
                decoration: const InputDecoration(hintText: 'Ej: Pastillas de freno'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa el nombre' : null,
              ),
              const SizedBox(height: 16),

              Text('MARCA COMPATIBLE (opcional)', style: AppTextStyles.caption),
              const SizedBox(height: 6),
              marcasAsync.when(
                data: (marcas) => DropdownButtonFormField<int>(
                  initialValue: _marcaSeleccionada,
                  hint: const Text('Universal (todas las marcas)'),
                  items: marcas
                      .map((m) => DropdownMenuItem(value: m.id, child: Text(m.nombre)))
                      .toList(),
                  onChanged: isLoading ? null : (v) => setState(() => _marcaSeleccionada = v),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Error al cargar marcas'),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('STOCK', style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _stockController,
                          enabled: !isLoading,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Requerido';
                            final n = int.tryParse(v);
                            if (n == null || n < 0) return 'Inválido';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PRECIO', style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _precioController,
                          enabled: !isLoading,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(prefixText: '\$ '),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Requerido';
                            final n = double.tryParse(v);
                            if (n == null || n < 0) return 'Inválido';
                            return null;
                          },
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
                      : Text(_esEdicion ? 'Guardar cambios' : 'Crear repuesto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}