// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/auth_state.dart';
<<<<<<< HEAD
import '../../domain/model/categoria.dart';
import '../../domain/model/marca.dart';
import '../../domain/model/moto.dart';
import '../../domain/model/venta_admin.dart';
=======
import '../../domain/model/inventario.dart';
import '../../domain/model/moto.dart';
import '../../domain/model/sucursal.dart';
>>>>>>> develop
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/catalogo/catalogo_screen.dart';
import '../screens/catalogo/moto_detail_screen.dart';
import '../screens/compra/carrito_screen.dart';
import '../screens/compra/compra_exitosa_screen.dart';
import '../screens/compra/mis_compras_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/admin_motos_screen.dart';
import '../screens/admin/moto_form_screen.dart';
<<<<<<< HEAD
import '../screens/admin/admin_ventas_screen.dart';
import '../screens/admin/venta_form_screen.dart';
import '../screens/admin/admin_marcas_screen.dart';
import '../screens/admin/marca_form_screen.dart';
import '../screens/admin/admin_categorias_screen.dart';
import '../screens/admin/categoria_form_screen.dart';
import '../screens/favoritos/favoritos_screen.dart';
=======
import '../screens/inventario/inventario_list_screen.dart';
import '../screens/inventario/inventario_form_screen.dart';
import '../screens/sucursal/sucursal_list_screen.dart';
import '../screens/sucursal/sucursal_form_screen.dart';
>>>>>>> develop

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}

class _PlaceholderScreen extends ConsumerWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 18))),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: _AuthStateListenable(ref),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isChecking = authState.isChecking;
      final isAuth = authState.isAuthenticated;
      final isStaff = authState.isStaff;
      final isAdmin = authState.isAdmin;
      final isBodeguero = authState.isBodeguero;
      final location = state.matchedLocation;

      if (isChecking) {
        return location == '/splash' ? null : '/splash';
      }

<<<<<<< HEAD
      const privateRoutes = ['/mis-compras', '/perfil', '/admin', '/carrito', '/compra-exitosa'];
=======
      const privateRoutes = ['/mis-compras', '/perfil', '/admin', '/sucursales'];
>>>>>>> develop
      final isPrivateRoute = privateRoutes.any((r) => location.startsWith(r));
      final isAuthRoute = location == '/login' || location == '/registro';
      final isSplash = location == '/splash';

      if (isSplash) return '/';

      if (isPrivateRoute && !isAuth) return '/login';

      if (location.startsWith('/admin') && isAuth && !isStaff) return '/';

      // Solo /sucursales/nuevo y /sucursales/:id/editar requieren isStaff;
      // el listado ('/sucursales') solo requiere estar autenticado (IsStaffOrReadOnly).
      if (location.startsWith('/sucursales/') && isAuth && !isStaff) return '/sucursales';

      if (location.startsWith('/inventario') && !(isAdmin || isBodeguero)) return '/';

      if (isAuth && isAuthRoute) return '/';

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const _SplashScreen()),

      // ── Auth ─────
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/registro', builder: (_, __) => const RegisterScreen()),

      // ── Público ─────
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/catalogo', builder: (_, __) => const CatalogoScreen()),
      GoRoute(
        path: '/moto/:id',
        builder: (_, state) => MotoDetailScreen(
          motoId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/favoritos',
        builder: (_, __) => const FavoritosScreen(),
      ),

      // ── Cliente privado ────
      GoRoute(
        path: '/carrito',
        builder: (_, __) => const CarritoScreen(),
      ),
      GoRoute(
        path: '/compra-exitosa',
        builder: (_, state) => CompraExitosaScreen(venta: state.extra as VentaAdmin),
      ),
      GoRoute(
        path: '/mis-compras',
        builder: (_, __) => const MisComprasScreen(),
      ),
      GoRoute(
        path: '/perfil',
        builder: (_, __) => const PerfilScreen(),
      ),

      // ── Inventario (admin / bodeguero) ─────
      GoRoute(
        path: '/inventario',
        builder: (_, __) => const InventarioListScreen(),
      ),
      GoRoute(
        path: '/inventario/nuevo',
        builder: (_, __) => const InventarioFormScreen(),
      ),
      GoRoute(
        path: '/inventario/:id/editar',
        builder: (_, state) => InventarioFormScreen(inventario: state.extra as Inventario),
      ),

      // ── Sucursales ─────
      GoRoute(
        path: '/sucursales',
        builder: (_, __) => const SucursalListScreen(),
      ),
      GoRoute(
        path: '/sucursales/nuevo',
        builder: (_, __) => const SucursalFormScreen(),
      ),
      GoRoute(
        path: '/sucursales/:id/editar',
        builder: (_, state) => SucursalFormScreen(sucursal: state.extra as Sucursal),
      ),

      // ── Admin ─────
      GoRoute(
        path: '/admin',
        builder: (_, __) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/motos',
        builder: (_, __) => const AdminMotosScreen(),
      ),
      GoRoute(
        path: '/admin/motos/crear',
        builder: (_, __) => const MotoFormScreen(),
      ),
      GoRoute(
        path: '/admin/motos/editar',
        builder: (_, state) => MotoFormScreen(moto: state.extra as Moto),
      ),
      GoRoute(
        path: '/admin/ventas',
        builder: (_, __) => const AdminVentasScreen(),
      ),
      GoRoute(
        path: '/admin/ventas/editar',
        builder: (_, state) => VentaFormScreen(ventaId: state.extra as int),
      ),
      GoRoute(
        path: '/admin/marcas',
        builder: (_, __) => const AdminMarcasScreen(),
      ),
      GoRoute(
        path: '/admin/marcas/crear',
        builder: (_, __) => const MarcaFormScreen(),
      ),
      GoRoute(
        path: '/admin/marcas/editar',
        builder: (_, state) => MarcaFormScreen(marca: state.extra as Marca),
      ),
      GoRoute(
        path: '/admin/categorias',
        builder: (_, __) => const AdminCategoriasScreen(),
      ),
      GoRoute(
        path: '/admin/categorias/crear',
        builder: (_, __) => const CategoriaFormScreen(),
      ),
      GoRoute(
        path: '/admin/categorias/editar',
        builder: (_, state) => CategoriaFormScreen(categoria: state.extra as Categoria),
      ),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}