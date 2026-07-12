import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/password_reset_provider.dart';

class SolicitarResetScreen extends ConsumerStatefulWidget {
  const SolicitarResetScreen({super.key});

  @override
  ConsumerState<SolicitarResetScreen> createState() => _SolicitarResetScreenState();
}

class _SolicitarResetScreenState extends ConsumerState<SolicitarResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    final exito = await ref.read(passwordResetProvider.notifier).solicitar(_usernameController.text.trim());

    if (!context.mounted) return;

    if (exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revisa tu correo, te enviamos un código'), backgroundColor: AppColors.success),
      );
      context.push('/recuperar-password/confirmar');
    } else {
      final error = ref.read(passwordResetProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'No se pudo enviar el código'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(passwordResetProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text('Recuperar contraseña', style: AppTextStyles.heading1),
                const SizedBox(height: 8),
                Text(
                  'Ingresa tu usuario y te enviaremos un código a tu correo registrado',
                  style: AppTextStyles.bodySecondary,
                ),

                const SizedBox(height: 28),

                Text('USUARIO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _usernameController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'tu usuario'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa tu usuario' : null,
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _enviar,
                    child: isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Enviar código'),
                  ),
                ),

                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: isLoading ? null : () => context.push('/recuperar-password/confirmar'),
                    child: const Text('Ya tengo un código', style: TextStyle(color: AppColors.accent)),
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