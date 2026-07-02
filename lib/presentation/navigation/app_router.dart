// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/auth_state.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';

// Pantalla temporal mientras se restaura la sesión
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}

// Placeholder genérico para pantallas que aún no existen
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
              context.go('/login');
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
      final location = state.matchedLocation;

      if (isChecking) {
        return location == '/splash' ? null : '/splash';
      }

      final isAuthRoute = location == '/login' || location == '/registro';
      final isSplash = location == '/splash';

      if (isSplash) return isAuth ? '/' : '/login';

      if (!isAuth && !isAuthRoute) return '/login';

      if (isAuth && isAuthRoute) return '/';

      if (isAuth && !isStaff && location.startsWith('/admin')) return '/';

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const _SplashScreen()),

      // ── Auth ─────
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: '/registro',
        builder: (_, __) => const _PlaceholderScreen('Registro — pendiente'),
      ),

      // ── Público ─────
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: '/catalogo',
        builder: (_, __) => const _PlaceholderScreen('Catálogo de motos'),
      ),
      GoRoute(
        path: '/moto/:id',
        builder: (_, __) => const _PlaceholderScreen('Detalle de moto'),
      ),

      // ── Cliente privado ────
      GoRoute(
        path: '/mis-compras',
        builder: (_, __) => const _PlaceholderScreen('Mis compras'),
      ),
      GoRoute(
        path: '/perfil',
        builder: (_, __) => const _PlaceholderScreen('Perfil'),
      ),

      // ── Admin ────
      GoRoute(
        path: '/admin',
        builder: (_, __) => const _PlaceholderScreen('Panel administrativo'),
      ),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}