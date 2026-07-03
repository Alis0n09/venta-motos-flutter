// lib/presentation/screens/auth/register_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/auth_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _cedulaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePassword2 = true;

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _cedulaController.dispose();
    _telefonoController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(authProvider.notifier).register(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          password2: _password2Controller.text,
          nombre: _nombreController.text.trim(),
          apellido: _apellidoController.text.trim(),
          cedula: _cedulaController.text.trim(),
          telefono: _telefonoController.text.trim().isEmpty
              ? null
              : _telefonoController.text.trim(),
        );
  }

  String? _requerido(String? value, String campo) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu $campo';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isUnauthenticated && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState.isChecking;

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

                Text('Crear cuenta', style: AppTextStyles.heading1),
                const SizedBox(height: 8),
                Text('Registrate para empezar a comprar', style: AppTextStyles.bodySecondary),

                const SizedBox(height: 28),

                Text('NOMBRE', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nombreController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Camila'),
                  validator: (v) => _requerido(v, 'nombre'),
                ),
                const SizedBox(height: 16),

                Text('APELLIDO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _apellidoController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'Torres'),
                  validator: (v) => _requerido(v, 'apellido'),
                ),
                const SizedBox(height: 16),

                Text('CÉDULA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _cedulaController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: '1234567890'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Ingresa tu cédula';
                    if (v.trim().length != 10) return 'La cédula debe tener 10 dígitos';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Text('TELÉFONO (opcional)', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _telefonoController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: '0991234567'),
                ),
                const SizedBox(height: 16),

                Text('USUARIO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _usernameController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'camila.torres'),
                  validator: (v) => _requerido(v, 'usuario'),
                ),
                const SizedBox(height: 16),

                Text('CORREO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'camila@gmail.com'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
                    if (!v.contains('@')) return 'Correo inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Text('CONTRASEÑA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  enabled: !isLoading,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: TextButton(
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      child: Text(
                        _obscurePassword ? 'VER' : 'OCULTAR',
                        style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ingresa una contraseña';
                    if (v.length < 8) return 'Mínimo 8 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Text('CONFIRMAR CONTRASEÑA', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _password2Controller,
                  enabled: !isLoading,
                  obscureText: _obscurePassword2,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: TextButton(
                      onPressed: () => setState(() => _obscurePassword2 = !_obscurePassword2),
                      child: Text(
                        _obscurePassword2 ? 'VER' : 'OCULTAR',
                        style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Confirma tu contraseña';
                    if (v != _passwordController.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),

                const SizedBox(height: 28),

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
                        : const Text('Crear cuenta'),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: TextButton(
                    onPressed: isLoading ? null : () => context.pop(),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: AppColors.textSecondary),
                        children: [
                          TextSpan(text: '¿Ya tienes cuenta? '),
                          TextSpan(
                            text: 'Inicia sesión',
                            style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}