// lib/presentation/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../providers/auth_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header del drawer ──────────────────────
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
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
                  Expanded(
                    child: Text('Venta de Motos', style: AppTextStyles.heading2),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            if (authState.isAuthenticated)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Hola, ${authState.user?.username}',
                  style: AppTextStyles.bodySecondary,
                ),
              ),

            const Divider(height: 32),

            // ── Opciones comunes a todos ────────────────
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Mis favoritos'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: context.push('/favoritos') cuando exista
              },
            ),
            ListTile(
              leading: const Icon(Icons.build_outlined),
              title: const Text('Agendar mantenimiento'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: context.push('/mantenimiento') cuando exista
              },
            ),

            // ── Solo cliente logueado ────────────────────
            if (authState.isAuthenticated && !authState.isStaff)
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Mis compras'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/mis-compras');
                },
              ),

            // ── Solo staff ────────────────────────────────
            if (authState.isStaff)
              ListTile(
                leading: const Icon(Icons.admin_panel_settings_outlined),
                title: const Text('Panel administrativo'),
                subtitle: Text('Rol: ${authState.rol}'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/admin');
                },
              ),

            const Spacer(),
            const Divider(height: 1),

            // ── Pie: login/logout ─────────────────────────
            if (authState.isAuthenticated)
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text('Cerrar sesión', style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.of(context).pop();
                  ref.read(authProvider.notifier).logout();
                },
              )
            else ...[
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Iniciar sesión'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add_outlined),
                title: const Text('Crear cuenta'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/registro');
                },
              ),
            ],

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}