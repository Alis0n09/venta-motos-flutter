// lib/presentation/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/auth_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(authProvider.notifier).login(
          _usernameController.text,
          _passwordController.text,
        );
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

                // ── Flecha para regresar ──────────────────
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
                const SizedBox(height: 8),

                // ── Header con logo ──────────────────────
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('V', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Victal Speed', style: AppTextStyles.heading2),
                  ],
                ),

                const SizedBox(height: 20),

                // ── Imagen destacada ──────────────────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/login2.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 28),

                Text('ACELERA\nTU COMPRA', style: AppTextStyles.heading1),
                const SizedBox(height: 8),
                Text('Inicia sesión para seguir con tu búsqueda', style: AppTextStyles.bodySecondary),

                const SizedBox(height: 28),

                // ── Campo correo/usuario ──────────────────
                Text('USUARIO', style: AppTextStyles.caption),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _usernameController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(hintText: 'tu usuario'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu usuario';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ── Campo contraseña ──────────────────────
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
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: isLoading ? null : () {
                      // TODO: pantalla de recuperar contraseña (fuera del alcance del proyecto por ahora)
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

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
                        : const Text('Continuar'),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: null, // deshabilitado: fuera del alcance del proyecto
                    icon: const Text('G', style: TextStyle(fontWeight: FontWeight.bold)),
                    label: const Text('Continuar con Google'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: TextButton(
                    onPressed: isLoading ? null : () => context.push('/registro'),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: AppColors.textSecondary),
                        children: [
                          TextSpan(text: '¿No tienes cuenta? '),
                          TextSpan(
                            text: 'Regístrate',
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