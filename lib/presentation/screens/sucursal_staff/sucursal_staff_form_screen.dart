// lib/presentation/screens/sucursal_staff/sucursal_staff_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/sucursal_staff.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/sucursal_provider.dart';
import '../../providers/sucursal_staff_admin_provider.dart';
import '../../providers/vendedor_provider.dart';

class SucursalStaffFormScreen extends ConsumerStatefulWidget {
  final SucursalStaff? asignacion;

  const SucursalStaffFormScreen({super.key, this.asignacion});

  @override
  ConsumerState<SucursalStaffFormScreen> createState() => _SucursalStaffFormScreenState();
}

class _SucursalStaffFormScreenState extends ConsumerState<SucursalStaffFormScreen> {
  int? _staffSeleccionado;
  int? _sucursalSeleccionada;

  bool get _esEdicion => widget.asignacion != null;

  @override
  void initState() {
    super.initState();
    _staffSeleccionado = widget.asignacion?.staff;
    _sucursalSeleccionada = widget.asignacion?.sucursal;
  }

  Future<void> _submit() async {
    if (_staffSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un empleado'), backgroundColor: AppColors.error),
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
      'staff': _staffSeleccionado,
      'sucursal': _sucursalSeleccionada,
    };

    final notifier = ref.read(sucursalStaffAdminProvider.notifier);
    final exito = _esEdicion
        ? await notifier.editar(widget.asignacion!.id, payload)
        : await notifier.crear(payload);

    if (!context.mounted) return;

    if (exito) {
      Navigator.of(context).pop();
    } else {
      final error = ref.read(sucursalStaffAdminProvider).error;
      final mensaje = _mensajeDeError(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje), backgroundColor: AppColors.error),
      );
    }
  }

  String _mensajeDeError(Object? error) {
    if (error is! ApiException) return error?.toString() ?? 'Error al guardar';
    if (error.statusCode == 403) return 'No tienes permisos para esta acción';
    if (error.statusCode == 400 && error.message.toLowerCase().contains('unique')) {
      return 'Este empleado ya está asignado a esa sucursal';
    }
    return error.message;
  }

  @override
  Widget build(BuildContext context) {
    final vendedoresAsync = ref.watch(vendedoresProvider);
    final sucursalesAsync = ref.watch(sucursalesTodasProvider);
    final adminState = ref.watch(sucursalStaffAdminProvider);
    final isLoading = adminState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
                        _esEdicion ? 'EDITAR ASIGNACIÓN' : 'NUEVA ASIGNACIÓN',
                        style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                      ),
                      Text(
                        _esEdicion ? widget.asignacion!.staffNombre : 'Asignar staff a sucursal',
                        style: AppTextStyles.heading2,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text('STAFF', style: AppTextStyles.caption),
              const SizedBox(height: 6),
              vendedoresAsync.when(
                data: (vendedores) => DropdownButtonFormField<int>(
                  initialValue: _staffSeleccionado,
                  hint: const Text('Elegir'),
                  isExpanded: true,
                  items: vendedores
                      .map((v) => DropdownMenuItem(
                            value: v.id,
                            child: Text(
                              '${v.nombre} ${v.apellido}${v.rol != null ? ' (${v.rol})' : ''}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ))
                      .toList(),
                  onChanged: isLoading ? null : (v) => setState(() => _staffSeleccionado = v),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('No se pudo cargar el staff'),
              ),
              const SizedBox(height: 16),

              const Text('SUCURSAL', style: AppTextStyles.caption),
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
                      : Text(_esEdicion ? 'Guardar cambios' : 'Crear asignación'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
