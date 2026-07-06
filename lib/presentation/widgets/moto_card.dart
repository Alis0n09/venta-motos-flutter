// lib/presentation/widgets/moto_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/moto.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../providers/favoritos_provider.dart';

class MotoCard extends StatelessWidget {
  final Moto moto;
  final VoidCallback? onTap;

  const MotoCard({super.key, required this.moto, this.onTap});

  @override
  Widget build(BuildContext context) {
    final precioFormateado = moto.precio.toStringAsFixed(0);

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: (moto.imagenUrl != null && moto.imagenUrl!.isNotEmpty)
                      ? Image.network(
                          moto.imagenUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholderIcono(),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return _placeholderIcono();
                          },
                        )
                      : _placeholderIcono(),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${moto.marcaNombre} ${moto.modelo}',
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${moto.cilindraje} cc · ${moto.anio}',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$$precioFormateado', style: AppTextStyles.price),
                  _BotonFavorito(motoId: moto.id),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderIcono() {
    return Container(
      color: AppColors.background,
      child: const Icon(Icons.two_wheeler, color: AppColors.textSecondary),
    );
  }
}

class _BotonFavorito extends ConsumerWidget {
  final int motoId;

  const _BotonFavorito({required this.motoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final esFavorito = ref.watch(favoritosProvider.select((ids) => ids.contains(motoId)));

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => ref.read(favoritosProvider.notifier).toggle(motoId),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          esFavorito ? Icons.favorite : Icons.favorite_border,
          size: 18,
          color: esFavorito ? AppColors.error : AppColors.textSecondary,
        ),
      ),
    );
  }
}