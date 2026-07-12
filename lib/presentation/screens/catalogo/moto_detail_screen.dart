// lib/presentation/screens/catalogo/moto_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/carrito_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/favoritos_provider.dart';
import '../../providers/resena_provider.dart';

class MotoDetailScreen extends ConsumerWidget {
  final int motoId;

  const MotoDetailScreen({
    super.key,
    required this.motoId,
  });

  Future<void> _abrirFormularioResena(BuildContext context, WidgetRef ref, String motoNombre) async {
    int ratingSeleccionado = 5;
    final comentarioController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final isLoading = ref.watch(resenaFormProvider).isLoading;
          return AlertDialog(
            title: Text('Calificar $motoNombre'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      final estrella = i + 1;
                      return IconButton(
                        onPressed: isLoading
                            ? null
                            : () => setDialogState(() => ratingSeleccionado = estrella),
                        icon: Icon(
                          estrella <= ratingSeleccionado ? Icons.star : Icons.star_border,
                          color: AppColors.accent,
                        ),
                      );
                    }),
                  ),
                  TextFormField(
                    controller: comentarioController,
                    enabled: !isLoading,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: '¿Qué te pareció la moto?'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe un comentario' : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        final exito = await ref.read(resenaFormProvider.notifier).enviar(
                              motoId: motoId,
                              rating: ratingSeleccionado,
                              comentario: comentarioController.text.trim(),
                            );
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(exito ? 'Reseña publicada' : 'No se pudo publicar la reseña'),
                              backgroundColor: exito ? AppColors.success : AppColors.error,
                            ),
                          );
                        }
                      },
                child: isLoading
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Publicar'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmarEliminarResena(BuildContext context, WidgetRef ref, int resenaId) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar reseña?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmar != true) return;

    final exito = await ref.read(resenaFormProvider.notifier).eliminar(id: resenaId, motoId: motoId);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Reseña eliminada' : 'No se pudo eliminar la reseña'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motoAsync = ref.watch(motoDetailProvider(motoId));
    final authState = ref.watch(authProvider);

    final esFavorito = ref.watch(
      favoritosProvider.select((ids) => ids.contains(motoId)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la moto'),
        actions: [
          IconButton(
            tooltip: esFavorito
                ? 'Quitar de favoritos'
                : 'Agregar a favoritos',
            onPressed: () {
              if (!authState.isAuthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Inicia sesión para guardar favoritos')),
                );
                context.push('/login');
                return;
              }
              ref.read(favoritosProvider.notifier).toggle(motoId);
            },
            icon: Icon(
              esFavorito ? Icons.favorite : Icons.favorite_border,
              color: esFavorito ? AppColors.error : null,
            ),
          ),
        ],
      ),
      body: motoAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text(
            'No se pudo cargar la moto',
            style: AppTextStyles.bodySecondary,
          ),
        ),
        data: (moto) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: (moto.imagenUrl != null &&
                        moto.imagenUrl!.isNotEmpty)
                    ? Image.network(
                        moto.imagenUrl!,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 220,
                          color: AppColors.background,
                          child: const Center(
                            child: Icon(
                              Icons.two_wheeler,
                              size: 96,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 220,
                        color: AppColors.background,
                        child: const Center(
                          child: Icon(
                            Icons.two_wheeler,
                            size: 96,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              Text(
                '${moto.marcaNombre} ${moto.modelo}',
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: 8),

              Text(
                '\$${moto.precio.toStringAsFixed(0)}',
                style: AppTextStyles.price.copyWith(
                  fontSize: 28,
                ),
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              Text(
                'Especificaciones',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: 12),

              _DetalleFila(
                label: 'Marca',
                valor: moto.marcaNombre,
              ),
              _DetalleFila(
                label: 'Modelo',
                valor: moto.modelo,
              ),
              _DetalleFila(
                label: 'Año',
                valor: '${moto.anio}',
              ),
              _DetalleFila(
                label: 'Color',
                valor: moto.color,
              ),
              _DetalleFila(
                label: 'Cilindraje',
                valor: '${moto.cilindraje} cc',
              ),
              if (moto.categoriaNombre != null)
                _DetalleFila(
                  label: 'Categoría',
                  valor: moto.categoriaNombre!,
                ),
              _DetalleFila(
                label: 'Estado',
                valor: moto.estado,
              ),
              _DetalleFila(
                label: 'Stock disponible',
                valor: '${moto.stock} unidades',
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: moto.stock > 0
                      ? () {
                          if (!authState.isCliente) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Inicia sesión como cliente para comprar.',
                                ),
                                backgroundColor: AppColors.error,
                              ),
                            );

                            if (!authState.isAuthenticated) {
                              context.push('/login');
                            }
                            return;
                          }

                          ref
                              .read(carritoProvider.notifier)
                              .agregarMoto(moto);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Agregada al carrito',
                              ),
                              backgroundColor: AppColors.success,
                              action: SnackBarAction(
                                label: 'Ver carrito',
                                onPressed: () {
                                  context.push('/carrito');
                                },
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    moto.stock > 0
                        ? 'Comprar'
                        : 'Sin stock',
                  ),
                ),
              ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Reseñas', style: AppTextStyles.heading2),
                  if (authState.isCliente)
                    TextButton(
                      onPressed: () => _abrirFormularioResena(
                        context,
                        ref,
                        '${moto.marcaNombre} ${moto.modelo}',
                      ),
                      child: const Text('Escribir reseña', style: TextStyle(color: AppColors.accent)),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              Consumer(
                builder: (context, ref, _) {
                  final resenasAsync = ref.watch(resenasPorMotoProvider(motoId));
                  return resenasAsync.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (_, __) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('No se pudieron cargar las reseñas', style: AppTextStyles.bodySecondary),
                    ),
                    data: (resenas) {
                      if (resenas.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Aún no hay reseñas para esta moto', style: AppTextStyles.bodySecondary),
                        );
                      }
                      final promedio = resenas.map((r) => r.rating).reduce((a, b) => a + b) / resenas.length;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.accent, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '${promedio.toStringAsFixed(1)} · ${resenas.length} reseña${resenas.length == 1 ? '' : 's'}',
                                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          for (final resena in resenas) ...[
                            _ResenaCard(
                              resena: resena,
                              puedeEliminar: authState.isAdmin,
                              onEliminar: () => _confirmarEliminarResena(context, ref, resena.id),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResenaCard extends StatelessWidget {
  final dynamic resena;
  final bool puedeEliminar;
  final VoidCallback onEliminar;

  const _ResenaCard({
    required this.resena,
    required this.puedeEliminar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    resena.clienteNombre ?? 'Cliente',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < resena.rating ? Icons.star : Icons.star_border,
                      size: 14,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                if (puedeEliminar)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onEliminar,
                  ),
              ],
            ),
            if (resena.comentario.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(resena.comentario, style: AppTextStyles.bodySecondary),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetalleFila extends StatelessWidget {
  final String label;
  final String valor;

  const _DetalleFila({
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySecondary,
          ),
          Text(
            valor,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}