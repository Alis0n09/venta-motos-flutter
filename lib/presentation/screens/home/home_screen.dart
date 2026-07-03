// lib/presentation/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/moto_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final catalogState = ref.watch(catalogProvider);

    return Scaffold(
      endDrawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(catalogProvider.notifier).loadMotos(),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // ── Header ──────────────────────────────
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
                  Text('Venta de Motos', style: AppTextStyles.heading2),
                  const Spacer(),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openEndDrawer(),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.accentLight,
                        child: Icon(
                          authState.isAuthenticated ? Icons.person : Icons.person_outline,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Saludo + título ───────────────────────
              if (authState.isAuthenticated)
                Text('Hola, ${authState.user?.username}', style: AppTextStyles.greeting),
              const SizedBox(height: 4),
              Text('Explorá el catálogo', style: AppTextStyles.heading1),

              const SizedBox(height: 20),

              // ── Buscador ──────────────────────────────
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Buscá marca, modelo...',
                  prefixIcon: Icon(Icons.search, color: AppColors.accent),
                ),
                onSubmitted: (value) => ref.read(catalogProvider.notifier).buscar(value),
              ),

              const SizedBox(height: 24),

              // ── Banner de oferta ──────────────────────
              ClipRect(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OFERTA DEL MES',
                            style: AppTextStyles.caption.copyWith(color: AppColors.accent),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '-15% + service\ngratis 6 meses',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'En tu primera compra',
                            style: AppTextStyles.bodySecondary.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── Lista de motos ────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recomendadas', style: AppTextStyles.heading2),
                  TextButton(
                    onPressed: () => context.push('/catalogo'),
                    child: const Text('Ver todas', style: TextStyle(color: AppColors.accent)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (catalogState.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (catalogState.error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(catalogState.error!, style: AppTextStyles.bodySecondary),
                  ),
                )
              else if (catalogState.motos.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: Text('No hay motos disponibles', style: AppTextStyles.bodySecondary)),
                )
              else
                for (final moto in catalogState.motos.take(5)) ...[
                  MotoCard(
                    moto: moto,
                    onTap: () => context.push('/moto/${moto.id}'),
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          switch (index) {
            case 1:
              context.push('/catalogo');
              break;
            case 2:
              // TODO: context.push('/favoritos') cuando exista
              break;
            case 3:
              if (authState.isAuthenticated) {
                context.push('/perfil');
              } else {
                context.push('/login');
              }
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}