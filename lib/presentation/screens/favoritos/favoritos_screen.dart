// lib/presentation/screens/favoritos/favoritos_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/favoritos_provider.dart';
import '../../widgets/moto_card.dart';

class FavoritosScreen extends ConsumerWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritosAsync = ref.watch(favoritosMotosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis favoritos')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(favoritosMotosProvider.future),
        child: favoritosAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('No se pudieron cargar tus favoritos', style: AppTextStyles.bodySecondary)),
            ],
          ),
          data: (motos) => motos.isEmpty
              ? ListView(
                  children: [
                    const SizedBox(height: 80),
                    const Center(
                      child: Icon(Icons.favorite_border, size: 48, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text('Todavía no tienes favoritos', style: AppTextStyles.bodySecondary),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        'Toca el corazón en cualquier moto para guardarla aquí',
                        style: AppTextStyles.bodySecondary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: motos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final moto = motos[index];
                    return MotoCard(
                      moto: moto,
                      onTap: () => context.push('/moto/${moto.id}'),
                    );
                  },
                ),
        ),
      ),
    );
  }
}