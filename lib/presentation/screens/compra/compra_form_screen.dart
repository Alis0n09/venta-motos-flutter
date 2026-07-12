// lib/presentation/screens/compra/compra_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/compra_registro_provider.dart';
import '../../providers/proveedor_provider.dart';
import '../../providers/sucursal_provider.dart';

class _LineaCompraForm {
  int? motoId;
  String? motoNombre;
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  void dispose() {
    cantidadController.dispose();
    precioController.dispose();
  }
}

class CompraFormScreen extends ConsumerStatefulWidget {
  const CompraFormScreen({super.key});

  @override
  ConsumerState<CompraFormScreen> createState() => _CompraFormScreenState();
}

class _CompraFormScreenState extends ConsumerState<CompraFormScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _proveedorSeleccionado;
  int? _sucursalSeleccionada;
  final List<_LineaCompraForm> _lineas = [_LineaCompraForm()];

  @override
  void dispose() {
    for (final linea in _lineas) {
      linea.dispose();
    }
    super.dispose();
  }

  void _agregarLinea() {
    setState(() => _lineas.add(_LineaCompraForm()));
  }

  void _eliminarLinea(int index) {
    if (_lineas.length <= 1) return;
    setState(() {
      _lineas[index].dispose();
      _lineas.removeAt(index);
    });
  }

  double get _total {
    var total = 0.0;
    for (final linea in _lineas) {
      final cantidad = int.tryParse(linea.cantidadController.text) ?? 0;
      final precio = double.tryParse(linea.precioController.text) ?? 0;
      total += cantidad * precio;
    }
    return total;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_proveedorSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un proveedor'), backgroundColor: AppColors.error),
      );
      return;
    }
    if (_sucursalSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una sucursal destino'), backgroundColor: AppColors.error),
      );
      return;
    }
    for (final linea in _lineas) {
      if (linea.motoId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecciona una moto en cada línea'), backgroundColor: AppColors.error),
        );
        return;
      }
    }

    final lineas = _lineas
        .map((l) => LineaCompra(
              motoId: l.motoId!,
              motoNombre: l.motoNombre ?? 'Moto #${l.motoId}',
              cantidad: int.parse(l.cantidadController.text),
              precioCosto: double.parse(l.precioController.text),
            ))
        .toList();

    final notifier = ref.read(compraRegistroProvider.notifier);
    final exito = await notifier.registrarCompra(
      proveedorId: _proveedorSeleccionado!,
      sucursalId: _sucursalSeleccionada!,
      lineas: lineas,
    );

    if (!context.mounted) return;

    if (!exito) {
      final error = ref.read(compraRegistroProvider).error;
      final mensaje = (error is ApiException && error.statusCode == 403)
          ? 'No tienes permisos para esta acción'
          : (error?.toString() ?? 'Error al registrar la compra');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje), backgroundColor: AppColors.error),
      );
      return;
    }

    final resultado = ref.read(compraRegistroProvider).value;

    if (resultado == null || !resultado.huboErrores) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compra registrada y stock actualizado correctamente'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.of(context).pop();
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Compra registrada con observaciones'),
        content: Text(
          'La compra se registró correctamente.\n\n'
          'Stock actualizado para: ${resultado.motosActualizadas.isEmpty ? "ninguna línea" : resultado.motosActualizadas.join(", ")}.\n\n'
          'No se pudo actualizar el stock de: ${resultado.motosConError.map((e) => e.motoNombre).join(", ")}. '
          'Corrígelo manualmente desde Inventario.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final proveedorState = ref.watch(proveedorProvider);
    final sucursalesAsync = ref.watch(sucursalesTodasProvider);
    final motosAsync = ref.watch(recomendadasProvider);
    final registroState = ref.watch(compraRegistroProvider);
    final isLoading = registroState.isLoading;

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
                          'NUEVA COMPRA',
                          style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                        ),
                        const Text('Registrar compra', style: AppTextStyles.heading2),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('PROVEEDOR', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                DropdownButtonFormField<int>(
                  initialValue: _proveedorSeleccionado,
                  hint: const Text('Elegir'),
                  isExpanded: true,
                  items: proveedorState.proveedores
                      .map((p) => DropdownMenuItem(
                            value: p.id,
                            child: Text(p.empresa, overflow: TextOverflow.ellipsis, maxLines: 1),
                          ))
                      .toList(),
                  onChanged: isLoading ? null : (v) => setState(() => _proveedorSeleccionado = v),
                ),
                const SizedBox(height: 16),

                const Text('SUCURSAL DESTINO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                sucursalesAsync.when(
                  data: (sucursales) => DropdownButtonFormField<int>(
                    initialValue: _sucursalSeleccionada,
                    hint: const Text('Elegir'),
                    isExpanded: true,
                    items: sucursales
                        .map((s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(s.nombre, overflow: TextOverflow.ellipsis, maxLines: 1),
                            ))
                        .toList(),
                    onChanged: isLoading ? null : (v) => setState(() => _sucursalSeleccionada = v),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('No se pudieron cargar las sucursales'),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('LÍNEAS DE COMPRA', style: AppTextStyles.caption),
                    TextButton.icon(
                      onPressed: isLoading ? null : _agregarLinea,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Agregar línea'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                motosAsync.when(
                  data: (motos) => Column(
                    children: [
                      for (var i = 0; i < _lineas.length; i++)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      initialValue: _lineas[i].motoId,
                                      hint: const Text('Moto'),
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
                                      onChanged: isLoading
                                          ? null
                                          : (v) => setState(() {
                                                _lineas[i].motoId = v;
                                                if (v == null) {
                                                  _lineas[i].motoNombre = null;
                                                } else {
                                                  final moto = motos.firstWhere((m) => m.id == v);
                                                  _lineas[i].motoNombre =
                                                      '${moto.marcaNombre} ${moto.modelo}';
                                                }
                                              }),
                                    ),
                                  ),
                                  if (_lineas.length > 1)
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                      onPressed: isLoading ? null : () => _eliminarLinea(i),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _lineas[i].cantidadController,
                                      enabled: !isLoading,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(labelText: 'Cantidad'),
                                      onChanged: (_) => setState(() {}),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) return 'Requerido';
                                        final n = int.tryParse(v);
                                        if (n == null || n <= 0) return 'Debe ser mayor a 0';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _lineas[i].precioController,
                                      enabled: !isLoading,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      decoration: const InputDecoration(
                                        labelText: 'Precio costo',
                                        prefixText: '\$ ',
                                      ),
                                      onChanged: (_) => setState(() {}),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) return 'Requerido';
                                        final n = double.tryParse(v);
                                        if (n == null || n <= 0) return 'Debe ser mayor a 0';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('No se pudieron cargar las motos'),
                ),

                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOTAL',
                        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\$${_total.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ],
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
                        : const Text('Registrar compra'),
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
