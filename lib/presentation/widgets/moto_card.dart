// lib/presentation/widgets/moto_card.dart

import 'package:flutter/material.dart';
import '../../domain/model/moto.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

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
                  const Icon(Icons.favorite_border, size: 18, color: AppColors.textSecondary),
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