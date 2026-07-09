// lib/presentation/screens/admin/moto_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/moto.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/moto_admin_provider.dart';

class MotoFormScreen extends ConsumerStatefulWidget {
  final Moto? moto;

  const MotoFormScreen({super.key, this.moto});

  @override
  ConsumerState<MotoFormScreen> createState() => _MotoFormScreenState();
}

class _MotoFormScreenState extends ConsumerState<MotoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _modeloController;
  late final TextEditingController _anioController;
  late final TextEditingController _colorController;
  late final TextEditingController _precioController;
  late final TextEditingController _cilindrajeController;
  late final TextEditingController _imagenUrlController;

  int? _marcaSeleccionada;
  int? _categoriaSeleccionada;
  String _estado = 'disponible';

  bool get _esEdicion => widget.moto != null;

  @override
  void initState() {
    super.initState();
    final moto = widget.moto;
    _modeloController = TextEditingController(text: moto?.modelo ?? '');
    _anioController = TextEditingController(text: moto?.anio.toString() ?? '');
    _colorController = TextEditingController(text: moto?.color ?? '');
    _precioController = TextEditingController(text: moto?.precio.toString() ?? '');
    _cilindrajeController = TextEditingController(text: moto?.cilindraje.toString() ?? '150');
    _imagenUrlController = TextEditingController(text: moto?.imagenUrl ?? '');
    _marcaSeleccionada = moto?.marca;
    _categoriaSeleccionada = moto?.categoria;
    _estado = moto?.estado ?? 'disponible';
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _anioController.dispose();
    _colorController.dispose();
    _precioController.dispose();
    _cilindrajeController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_marcaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una marca'), backgroundColor: AppColors.error),
      );
      return;
    }

    final payload = {
      'marca': _marcaSeleccionada,
      if (_categoriaSeleccionada != null) 'categoria': _categoriaSeleccionada,
      'modelo': _modeloController.text.trim(),
      'anio': int.parse(_anioController.text),
      'color': _colorController.text.trim(),
      'precio': double.parse(_precioController.text),
      'cilindraje': int.parse(_cilindrajeController.text),
      'estado': _estado,
      if (_imagenUrlController.text.trim().isNotEmpty)
        'imagen_url': _imagenUrlController.text.trim(),
    };

    final notifier = ref.read(motoAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.moto!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(motoAdminProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'Error al guardar'), backgroundColor: AppColors.error),
      );
    }
  }

  Future<void> _confirmarEliminar() async {
    if (widget.moto == null) return;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar moto?'),
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

    final exito = await ref.read(motoAdminProvider.notifier).eliminar(widget.moto!.id);
    if (!mounted) return;
    if (exito) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final marcasAsync = ref.watch(marcasProvider);
    final categoriasAsync = ref.watch(categoriasProvider);
    final adminState = ref.watch(motoAdminProvider);
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
                          _esEdicion ? 'EDITAR MOTO' : 'NUEVA MOTO',
                          style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                        ),
                        Text(
                          _esEdicion ? '${widget.moto!.marcaNombre} ${widget.moto!.modelo}' : 'Crear moto',
                          style: AppTextStyles.heading2,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Imagen ─────────────────────────────────
                Text('URL DE LA IMAGEN', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _imagenUrlController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'https://...'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 10),

                if (_imagenUrlController.text.trim().isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _imagenUrlController.text.trim(),
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 140,
                        color: AppColors.border.withValues(alpha: 0.3),
                        child: const Center(
                          child: Text(
                            'No se pudo cargar esa URL',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                Text('MODELO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _modeloController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'FZ, CBR, etc.'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa el modelo' : null,
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MARCA', style: AppTextStyles.caption),
                          const SizedBox(height: 6),
                          marcasAsync.when(
                            data: (marcas) => DropdownButtonFormField<int>(
                              initialValue: _marcaSeleccionada,
                              hint: const Text('Elegir'),
                              items: marcas
                                  .map((m) => DropdownMenuItem(value: m.id, child: Text(m.nombre)))
                                  .toList(),
                              onChanged: isLoading ? null : (v) => setState(() => _marcaSeleccionada = v),
                            ),
                            loading: () => const LinearProgressIndicator(),
                            error: (_, __) => const Text('Error'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CILINDRAJE', style: AppTextStyles.caption),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _cilindrajeController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(suffixText: 'cc'),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Requerido';
                              final n = int.tryParse(v);
                              if (n == null || n <= 0) return 'Inválido';
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text('TIPO', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                categoriasAsync.when(
                  data: (categorias) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categorias.map((cat) {
                      final seleccionada = _categoriaSeleccionada == cat.id;
                      return ChoiceChip(
                        label: Text(cat.nombre),
                        selected: seleccionada,
                        onSelected: isLoading
                            ? null
                            : (_) => setState(() => _categoriaSeleccionada = seleccionada ? null : cat.id),
                        labelStyle: TextStyle(color: seleccionada ? Colors.white : AppColors.textPrimary),
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: seleccionada ? AppColors.primary : AppColors.border),
                        ),
                      );
                    }).toList(),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('No se pudieron cargar las categorías'),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AÑO', style: AppTextStyles.caption),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _anioController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Requerido';
                              final n = int.tryParse(v);
                              if (n == null || n <= 0) return 'Inválido';
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
                          Text('COLOR', style: AppTextStyles.caption),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _colorController,
                            enabled: !isLoading,
                            validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              if (n == null || n <= 0) return 'Inválido';
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
                          Row(
                            children: [
                              Text('STOCK', style: AppTextStyles.caption),
                              const SizedBox(width: 4),
                              Tooltip(
                                message: 'El stock se gestiona desde Inventario, no aquí',
                                child: Icon(Icons.info_outline, size: 14, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColors.border.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              _esEdicion ? '${widget.moto!.stock} unidades' : 'Se define en Inventario',
                              style: AppTextStyles.bodySecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text('ESTADO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _estado,
                  items: const [
                    DropdownMenuItem(value: 'disponible', child: Text('Disponible')),
                    DropdownMenuItem(value: 'vendida', child: Text('Vendida')),
                    DropdownMenuItem(value: 'reservada', child: Text('Reservada')),
                  ],
                  onChanged: isLoading ? null : (value) => setState(() => _estado = value!),
                ),

                const SizedBox(height: 32),

                if (_esEdicion)
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
                          : const Text('Crear moto'),
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