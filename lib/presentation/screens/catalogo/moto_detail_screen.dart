// lib/presentation/screens/catalogo/moto_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/catalog_provider.dart';

class MotoDetailScreen extends ConsumerWidget {
  final int motoId;

  const MotoDetailScreen({super.key, required this.motoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motoAsync = ref.watch(motoDetailProvider(motoId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de la moto')),
      body: motoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('No se pudo cargar la moto', style: AppTextStyles.bodySecondary),
        ),
        data: (moto) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: (moto.imagenUrl != null && moto.imagenUrl!.isNotEmpty)
                    ? Image.network(
                        moto.imagenUrl!,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 220,
                          color: AppColors.background,
                          child: const Center(
                            child: Icon(Icons.two_wheeler, size: 96, color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    : Container(
                        height: 220,
                        color: AppColors.background,
                        child: const Center(
                          child: Icon(Icons.two_wheeler, size: 96, color: AppColors.textSecondary),
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              Text('${moto.marcaNombre} ${moto.modelo}', style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text('\$${moto.precio.toStringAsFixed(0)}', style: AppTextStyles.price.copyWith(fontSize: 28)),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              Text('Especificaciones', style: AppTextStyles.heading2),
              const SizedBox(height: 12),

              _DetalleFila(label: 'Marca', valor: moto.marcaNombre),
              _DetalleFila(label: 'Modelo', valor: moto.modelo),
              _DetalleFila(label: 'Año', valor: '${moto.anio}'),
              _DetalleFila(label: 'Color', valor: moto.color),
              _DetalleFila(label: 'Cilindraje', valor: '${moto.cilindraje} cc'),
              if (moto.categoriaNombre != null)
                _DetalleFila(label: 'Categoría', valor: moto.categoriaNombre!),
              _DetalleFila(label: 'Estado', valor: moto.estado),
              _DetalleFila(label: 'Stock disponible', valor: '${moto.stock} unidades'),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: moto.stock > 0
                      ? () {
                          // TODO: agregar al carrito / comprar (módulo de Ventas, no es tuyo)
                        }
                      : null,
                  child: Text(moto.stock > 0 ? 'Comprar' : 'Sin stock'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetalleFila extends StatelessWidget {
  final String label;
  final String valor;

  const _DetalleFila({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySecondary),
          Text(valor, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}