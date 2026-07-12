// lib/presentation/screens/perfil/perfil_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/perfil_provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/notificacion_cliente_provider.dart';

class PerfilScreen extends ConsumerStatefulWidget {
  const PerfilScreen({super.key});

  @override
  ConsumerState<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends ConsumerState<PerfilScreen> {
  void _mostrarResultado(bool exito, String mensajeExito) {
    if (!mounted) return;
    final perfilState = ref.read(perfilNotifierProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(exito ? mensajeExito : perfilState.error?.toString() ?? 'Error al guardar'),
        backgroundColor: exito ? AppColors.success : AppColors.error,
      ),
    );
  }

  Future<void> _abrirDatosPersonales({
    required bool esStaff,
    String? telefonoActual,
    String? direccionActual,
  }) async {
    final cuenta = ref.read(perfilCuentaProvider).value;
    final nombreController = TextEditingController(text: cuenta?.firstName ?? '');
    final apellidoController = TextEditingController(text: cuenta?.lastName ?? '');
    final emailController = TextEditingController(text: cuenta?.email ?? '');
    final telefonoController = TextEditingController(text: telefonoActual ?? '');
    final direccionController = TextEditingController(text: direccionActual ?? '');
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final isLoading = ref.watch(perfilNotifierProvider).isLoading;
          return AlertDialog(
            title: const Text('Datos personales'),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nombreController,
                      enabled: !isLoading,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: apellidoController,
                      enabled: !isLoading,
                      decoration: const InputDecoration(labelText: 'Apellido'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      enabled: !isLoading,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Correo'),
                      validator: (v) => (v == null || !v.contains('@')) ? 'Correo inválido' : null,
                    ),
                    if (!esStaff) ...[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: telefonoController,
                        enabled: !isLoading,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(labelText: 'Teléfono'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: direccionController,
                        enabled: !isLoading,
                        decoration: const InputDecoration(labelText: 'Dirección'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;

                        final exitoCuenta = await ref.read(perfilNotifierProvider.notifier).guardarCuenta({
                          'email': emailController.text.trim(),
                          'first_name': nombreController.text.trim(),
                          'last_name': apellidoController.text.trim(),
                        });

                        var exitoCliente = true;
                        if (!esStaff) {
                          exitoCliente = await ref.read(perfilNotifierProvider.notifier).guardarCliente({
                            'telefono': telefonoController.text.trim(),
                            'direccion': direccionController.text.trim(),
                          });
                        }

                        if (context.mounted) Navigator.of(context).pop();
                        _mostrarResultado(exitoCuenta && exitoCliente, 'Datos actualizados');
                      },
                child: isLoading
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Guardar'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final cuentaAsync = ref.watch(perfilCuentaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: cuentaAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('No se pudo cargar tu perfil')),
        data: (cuenta) {
          if (authState.isStaff) {
            return _buildStaff(cuenta);
          }

          final clienteAsync = ref.watch(perfilClienteProvider);
          return clienteAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: Text('No se pudo cargar tu perfil')),
            data: (cliente) => _buildCliente(cuenta, cliente),
          );
        },
      ),
    );
  }

  Widget _buildBanner({required String username, required String subtitulo}) {
    return ClipRect(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.accent,
                  child: Text(
                    username.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subtitulo, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text('@$username', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaff(cuenta) {
    final nombreCompleto = (cuenta.firstName != null && cuenta.firstName!.isNotEmpty)
        ? '${cuenta.firstName} ${cuenta.lastName ?? ''}'.trim()
        : cuenta.username;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBanner(username: cuenta.username, subtitulo: nombreCompleto),
          const SizedBox(height: 12),
          Text(
            'Rol: ${ref.read(authProvider).rol}',
            style: AppTextStyles.bodySecondary,
          ),

          const SizedBox(height: 24),
          Text('DATOS PERSONALES', style: AppTextStyles.caption),
          const SizedBox(height: 12),

          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoFila(label: 'Nombre completo', valor: nombreCompleto),
                  const Divider(height: 20),
                  _InfoFila(label: 'Correo', valor: cuenta.email),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          Text('CUENTA', style: AppTextStyles.caption),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: _FilaMenu(
              icono: Icons.person_outline,
              titulo: 'Datos personales',
              onTap: () => _abrirDatosPersonales(esStaff: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCliente(cuenta, cliente) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBanner(
            username: cuenta.username,
            subtitulo: '${cliente.nombre} ${cliente.apellido}',
          ),

          const SizedBox(height: 24),
          Text('DATOS PERSONALES', style: AppTextStyles.caption),
          const SizedBox(height: 12),

          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoFila(label: 'Nombre completo', valor: '${cliente.nombre} ${cliente.apellido}'),
                  const Divider(height: 20),
                  _InfoFila(label: 'Cédula', valor: cliente.cedula),
                  const Divider(height: 20),
                  _InfoFila(label: 'Teléfono', valor: cliente.telefono?.isNotEmpty == true ? cliente.telefono! : 'No registrado'),
                  const Divider(height: 20),
                  _InfoFila(label: 'Dirección', valor: cliente.direccion?.isNotEmpty == true ? cliente.direccion! : 'No registrada'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          Text('CUENTA', style: AppTextStyles.caption),
          const SizedBox(height: 12),

          Card(
            margin: EdgeInsets.zero,
            child: _FilaMenu(
              icono: Icons.person_outline,
              titulo: 'Datos personales',
              onTap: () => _abrirDatosPersonales(
                esStaff: false,
                telefonoActual: cliente.telefono,
                direccionActual: cliente.direccion,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoFila extends StatelessWidget {
  final String label;
  final String valor;

  const _InfoFila({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySecondary),
        Flexible(
          child: Text(
            valor,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _FilaMenu extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final VoidCallback onTap;

  const _FilaMenu({required this.icono, required this.titulo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.accentLight,
        child: Icon(icono, color: AppColors.accent, size: 20),
      ),
      title: Text(titulo, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}