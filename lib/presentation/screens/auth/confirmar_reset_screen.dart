import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/password_reset_provider.dart';

class ConfirmarResetScreen extends ConsumerStatefulWidget {
  const ConfirmarResetScreen({super.key});

  @override
  ConsumerState<ConfirmarResetScreen> createState() => _ConfirmarResetScreenState();
}

class _ConfirmarResetScreenState extends ConsumerState<ConfirmarResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _codigoController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  Future<void> _confirmar() async {
    if (!_formKey.currentState!.validate()) return;

    final exito = await ref.read(passwordResetProvider.notifier).confirmar(
          codigo: _codigoController.text.trim(),
          newPassword: _passwordController.text,
          newPassword2: _password2Controller.text,
        );

    if (!context.mounted) return;

    if (exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada, ya puedes iniciar sesión'), backgroundColor: AppColors.success),
      );
      context.go('/login');
    } else {
      final error = ref.read(passwordResetProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'No se pudo actualizar la contraseña'), backgroundColor: AppColors.error),
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

                Text('Ingresa el código', style: AppTextStyles.heading1),
                const SizedBox(height: 8),
                Text(
                  'Revisa tu correo y pega el código que te enviamos',
                  style: AppTextStyles.bodySecondary,
                ),

                const SizedBox(height: 28),

                Text('CÓDIGO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _codigoController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Pega aquí el código'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa el código' : null,
                ),
                const SizedBox(height: 16),

                Text('CONTRASEÑA NUEVA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  enabled: !isLoading,
                  obscureText: _obscure1,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: TextButton(
                      onPressed: () => setState(() => _obscure1 = !_obscure1),
                      child: Text(_obscure1 ? 'VER' : 'OCULTAR',
                          style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 8) ? 'Mínimo 8 caracteres' : null,
                ),
                const SizedBox(height: 16),

                Text('CONFIRMAR CONTRASEÑA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _password2Controller,
                  enabled: !isLoading,
                  obscureText: _obscure2,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: TextButton(
                      onPressed: () => setState(() => _obscure2 = !_obscure2),
                      child: Text(_obscure2 ? 'VER' : 'OCULTAR',
                          style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                  ),
                  validator: (v) => (v != _passwordController.text) ? 'Las contraseñas no coinciden' : null,
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _confirmar,
                    child: isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Cambiar contraseña'),
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