// lib/presentation/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Venta Motos'),
        actions: [
          if (authState.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Cerrar sesión',
              onPressed: () => ref.read(authProvider.notifier).logout(),
            )
          else
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'Iniciar sesión',
              onPressed: () => context.push('/login'),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              if (authState.isAuthenticated)
                Text(
                  'Hola, ${authState.user?.username} 👋',
                  style: AppTextStyles.heading2,
                )
              else
                Text('Bienvenido', style: AppTextStyles.heading2),

              const SizedBox(height: 8),
              Text(
                'Encuentra la moto perfecta para ti',
                style: AppTextStyles.bodySecondary,
              ),

              const SizedBox(height: 32),

              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.two_wheeler,
                    size: 72,
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Text('Explora', style: AppTextStyles.heading2),
              const SizedBox(height: 16),

              _HomeMenuCard(
                icon: Icons.two_wheeler_outlined,
                title: 'Catálogo de motos',
                subtitle: 'Mira todos los modelos disponibles',
                onTap: () => context.go('/catalogo'),
              ),
              const SizedBox(height: 12),

              if (authState.isAuthenticated && !authState.isStaff)
                _HomeMenuCard(
                  icon: Icons.receipt_long_outlined,
                  title: 'Mis compras',
                  subtitle: 'Revisa tu historial de compras',
                  onTap: () => context.go('/mis-compras'),
                ),

              if (authState.isStaff)
                _HomeMenuCard(
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'Panel administrativo',
                  subtitle: 'Rol: ${authState.rol}',
                  onTap: () => context.go('/admin'),
                ),

              if (!authState.isAuthenticated) ...[
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => context.push('/login'),
                  child: const Text('Iniciar sesión'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.push('/registro'),
                  child: const Text('Crear cuenta nueva'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeMenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTextStyles.body),
        subtitle: Text(subtitle, style: AppTextStyles.bodySecondary),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}