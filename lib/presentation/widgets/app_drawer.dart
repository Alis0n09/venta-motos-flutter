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
            // ── Header del drawer (fijo arriba) ─────────
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
                    child: Text('Victal Speed', style: AppTextStyles.heading2),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Scaffold.of(context).closeEndDrawer(),
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

            // ── Opciones del menú (esto sí puede desplazarse) ──
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: const Text('Mis favoritos'),
                    onTap: () {
                      Scaffold.of(context).closeEndDrawer();
                      context.push('/favoritos');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.build_outlined),
                    title: const Text('Agendar mantenimiento'),
                    onTap: () {
                      Scaffold.of(context).closeEndDrawer();
                      context.push('/mantenimiento');
                    },
                  ),

                  if (authState.isAuthenticated && !authState.isStaff)
                    ListTile(
                      leading: const Icon(Icons.receipt_long_outlined),
                      title: const Text('Mis compras'),
                      onTap: () {
                        Scaffold.of(context).closeEndDrawer();
                        context.go('/mis-compras');
                      },
                    ),

                  if (authState.isStaff)
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings_outlined),
                      title: const Text('Panel administrativo'),
                      subtitle: Text('Rol: ${authState.rol}'),
                      onTap: () {
                        Scaffold.of(context).closeEndDrawer();
                        context.push('/admin');
                      },
                    ),

                  if (authState.isAdmin || authState.isBodeguero)
                    ListTile(
                      leading: const Icon(Icons.warehouse_outlined),
                      title: const Text('Inventario'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/inventario');
                      },
                    ),

                  if (authState.isAdmin || authState.isBodeguero)
                    ListTile(
                      leading: const Icon(Icons.local_shipping_outlined),
                      title: const Text('Proveedores'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/proveedores');
                      },
                    ),

                  if (authState.isAdmin || authState.isBodeguero)
                    ListTile(
                      leading: const Icon(Icons.shopping_cart_outlined),
                      title: const Text('Compras'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/compras');
                      },
                    ),

                  if (authState.isStaff)
                    ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: const Text('Direcciones'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/direcciones');
                      },
                    ),

                  if (authState.isStaff)
                    ListTile(
                      leading: const Icon(Icons.badge_outlined),
                      title: const Text('Asignaciones de staff'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/sucursal-staff');
                      },
                    ),

                  if (authState.isStaff)
                    ListTile(
                      leading: const Icon(Icons.history_outlined),
                      title: const Text('Logs de actividad'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/logs-actividad');
                      },
                    ),

                  if (authState.isStaff)
                    ListTile(
                      leading: const Icon(Icons.store_outlined),
                      title: const Text('Sucursales'),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/sucursales');
                      },
                    ),
                ],
              ),
            ),

            const Divider(height: 1),

            // ── Pie: login/logout (fijo abajo) ────────────
            if (authState.isAuthenticated)
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text('Cerrar sesión', style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                  ref.read(authProvider.notifier).logout();
                },
              )
            else ...[
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Iniciar sesión'),
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                  context.push('/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add_outlined),
                title: const Text('Crear cuenta'),
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
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