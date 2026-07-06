// lib/presentation/screens/direccion/direccion_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/direccion.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/cliente_provider.dart';
import '../../providers/direccion_admin_provider.dart';

class DireccionFormScreen extends ConsumerStatefulWidget {
  final Direccion? direccion;

  const DireccionFormScreen({super.key, this.direccion});

  @override
  ConsumerState<DireccionFormScreen> createState() => _DireccionFormScreenState();
}

class _DireccionFormScreenState extends ConsumerState<DireccionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _calleController;
  late final TextEditingController _ciudadController;
  late final TextEditingController _provinciaController;

  int? _clienteSeleccionado;
  bool _principal = false;

  bool get _esEdicion => widget.direccion != null;

  @override
  void initState() {
    super.initState();
    final direccion = widget.direccion;
    _calleController = TextEditingController(text: direccion?.calle ?? '');
    _ciudadController = TextEditingController(text: direccion?.ciudad ?? '');
    _provinciaController = TextEditingController(text: direccion?.provincia ?? '');
    _clienteSeleccionado = direccion?.cliente;
    _principal = direccion?.principal ?? false;
  }

  @override
  void dispose() {
    _calleController.dispose();
    _ciudadController.dispose();
    _provinciaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_clienteSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un cliente'), backgroundColor: AppColors.error),
      );
      return;
    }

    final payload = {
      'cliente': _clienteSeleccionado,
      'calle': _calleController.text.trim(),
      'ciudad': _ciudadController.text.trim(),
      'provincia': _provinciaController.text.trim(),
      'principal': _principal,
    };

    final notifier = ref.read(direccionAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.direccion!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(direccionAdminProvider).error;
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
    final clientesAsync = ref.watch(clientesProvider);
    final adminState = ref.watch(direccionAdminProvider);
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
                          _esEdicion ? 'EDITAR DIRECCIÓN' : 'NUEVA DIRECCIÓN',
                          style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                        ),
                        Text(
                          _esEdicion ? widget.direccion!.calle : 'Crear dirección',
                          style: AppTextStyles.heading2,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('CLIENTE', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                clientesAsync.when(
                  data: (clientes) => DropdownButtonFormField<int>(
                    initialValue: _clienteSeleccionado,
                    hint: const Text('Elegir'),
                    isExpanded: true,
                    items: clientes
                        .map((c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(
                                '${c.nombre} ${c.apellido} · ${c.cedula}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ))
                        .toList(),
                    onChanged: isLoading ? null : (v) => setState(() => _clienteSeleccionado = v),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('No se pudieron cargar los clientes'),
                ),
                const SizedBox(height: 16),

                const Text('CALLE', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _calleController,
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

                const Text('PROVINCIA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _provinciaController,
                  enabled: !isLoading,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dirección principal'),
                  value: _principal,
                  onChanged: isLoading ? null : (v) => setState(() => _principal = v),
                ),

                const SizedBox(height: 24),

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
                        : Text(_esEdicion ? 'Guardar cambios' : 'Crear dirección'),
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
