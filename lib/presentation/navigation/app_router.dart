// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/auth_state.dart';
import '../../domain/model/categoria.dart';
import '../../domain/model/cuota_pago.dart';
import '../../domain/model/direccion.dart';
import '../../domain/model/inventario.dart';
import '../../domain/model/marca.dart';
import '../../domain/model/moto.dart';
import '../../domain/model/proveedor.dart';
import '../../domain/model/sucursal.dart';
import '../../domain/model/sucursal_staff.dart';
import '../../domain/model/venta_admin.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/catalogo/catalogo_screen.dart';
import '../screens/catalogo/moto_detail_screen.dart';
import '../screens/compra/carrito_screen.dart';
import '../screens/compra/compra_exitosa_screen.dart';
import '../screens/compra/mis_compras_screen.dart';
import '../screens/compra/compra_list_screen.dart';
import '../screens/compra/compra_form_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/admin_motos_screen.dart';
import '../screens/admin/moto_form_screen.dart';
import '../screens/admin/admin_ventas_screen.dart';
import '../screens/admin/venta_form_screen.dart';
import '../screens/admin/admin_marcas_screen.dart';
import '../screens/admin/marca_form_screen.dart';
import '../screens/admin/admin_categorias_screen.dart';
import '../screens/admin/categoria_form_screen.dart';
import '../screens/admin/admin_financiamientos_screen.dart';
import '../screens/admin/financiamiento_screen.dart';
import '../screens/admin/cuota_form_screen.dart';
import '../screens/favoritos/favoritos_screen.dart';
import '../screens/inventario/inventario_list_screen.dart';
import '../screens/inventario/inventario_form_screen.dart';
import '../screens/sucursal/sucursal_list_screen.dart';
import '../screens/sucursal/sucursal_form_screen.dart';
import '../screens/proveedor/proveedor_list_screen.dart';
import '../screens/proveedor/proveedor_form_screen.dart';
import '../screens/direccion/direccion_list_screen.dart';
import '../screens/direccion/direccion_form_screen.dart';
import '../screens/sucursal_staff/sucursal_staff_list_screen.dart';
import '../screens/sucursal_staff/sucursal_staff_form_screen.dart';
import '../screens/logs_actividad/logs_actividad_list_screen.dart';
import '../screens/perfil/perfil_screen.dart';
import '../screens/admin/admin_garantias_screen.dart';
import '../screens/admin/garantia_form_screen.dart';
import '../../domain/model/garantia.dart';
import '../screens/admin/admin_repuestos_screen.dart';
import '../screens/admin/repuesto_form_screen.dart';
import '../../domain/model/repuesto.dart';
import '../screens/mantenimiento/mantenimiento_screen.dart';

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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

      const privateRoutes = [
        '/mis-compras',
        '/perfil',
        '/admin',
        '/carrito',
        '/compra-exitosa',
        '/sucursales',
      ];
      final isPrivateRoute = privateRoutes.any((r) => location.startsWith(r));
      final isAuthRoute = location == '/login' || location == '/registro';
      final isSplash = location == '/splash';

      if (isSplash) return '/';

      if (isPrivateRoute && !isAuth) return '/login';

      if (location.startsWith('/admin') && isAuth && !isStaff) return '/';

      if (location.startsWith('/sucursales/') && isAuth && !isStaff) return '/sucursales';

      if (location.startsWith('/inventario') && !(isAdmin || isBodeguero)) return '/';

      if (location.startsWith('/proveedores') && !(isAdmin || isBodeguero)) return '/';

      if (location.startsWith('/compras') && !(isAdmin || isBodeguero)) return '/';

      if (location.startsWith('/direcciones') && !isStaff) return '/';

      if (location.startsWith('/sucursal-staff') && !isStaff) return '/';

      if (location.startsWith('/logs-actividad') && !isStaff) return '/';

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

      // ── Proveedores (admin / bodeguero) ─────
      GoRoute(
        path: '/proveedores',
        builder: (_, __) => const ProveedorListScreen(),
      ),
      GoRoute(
        path: '/proveedores/nuevo',
        builder: (_, __) => const ProveedorFormScreen(),
      ),
      GoRoute(
        path: '/proveedores/:id/editar',
        builder: (_, state) => ProveedorFormScreen(proveedor: state.extra as Proveedor),
      ),

      // ── Compras (admin / bodeguero) ─────
      GoRoute(
        path: '/compras',
        builder: (_, __) => const CompraListScreen(),
      ),
      GoRoute(
        path: '/compras/nueva',
        builder: (_, __) => const CompraFormScreen(),
      ),

      // ── Direcciones (solo staff) ─────
      GoRoute(
        path: '/direcciones',
        builder: (_, __) => const DireccionListScreen(),
      ),
      GoRoute(
        path: '/direcciones/nuevo',
        builder: (_, __) => const DireccionFormScreen(),
      ),
      GoRoute(
        path: '/direcciones/:id/editar',
        builder: (_, state) => DireccionFormScreen(direccion: state.extra as Direccion),
      ),

      // ── Asignaciones de staff a sucursal (solo staff) ─────
      GoRoute(
        path: '/sucursal-staff',
        builder: (_, __) => const SucursalStaffListScreen(),
      ),
      GoRoute(
        path: '/sucursal-staff/nuevo',
        builder: (_, __) => const SucursalStaffFormScreen(),
      ),
      GoRoute(
        path: '/sucursal-staff/:id/editar',
        builder: (_, state) => SucursalStaffFormScreen(asignacion: state.extra as SucursalStaff),
      ),

      // ── Logs de actividad (solo staff, solo lectura) ─────
      GoRoute(
        path: '/logs-actividad',
        builder: (_, __) => const LogsActividadListScreen(),
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

      GoRoute(
        path: '/admin/garantias',
        builder: (_, __) => const AdminGarantiasScreen(),
      ),
      GoRoute(
        path: '/admin/garantias/crear',
        builder: (_, __) => const GarantiaFormScreen(),
      ),
      GoRoute(
        path: '/admin/garantias/editar',
        builder: (_, state) => GarantiaFormScreen(garantia: state.extra as Garantia),
      ),

      GoRoute(path: '/admin/repuestos', builder: (_, __) => const AdminRepuestosScreen()),
      GoRoute(path: '/admin/repuestos/crear', builder: (_, __) => const RepuestoFormScreen()),
      GoRoute(
        path: '/admin/repuestos/editar',
        builder: (_, state) => RepuestoFormScreen(repuesto: state.extra as Repuesto),
      ),
      
      GoRoute(
        path: '/mantenimiento',
        builder: (_, __) => const MantenimientoScreen(),
      ),

      // ── Financiamientos ─────
      GoRoute(
        path: '/admin/financiamientos',
        builder: (_, __) => const AdminFinanciamientosScreen(),
      ),
      GoRoute(
        path: '/admin/financiamientos/detalle',
        builder: (_, state) => FinanciamientoScreen(ventaId: state.extra as int),
      ),
      GoRoute(
        path: '/admin/cuotas/crear',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return CuotaFormScreen(financiamientoId: extra['financiamientoId'] as int);
        },
      ),
      GoRoute(
        path: '/admin/cuotas/editar',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return CuotaFormScreen(
            financiamientoId: extra['financiamientoId'] as int,
            cuota: extra['cuota'] as CuotaPago,
          );
        },
      ),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}