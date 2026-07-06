// lib/presentation/screens/admin/admin_historial_precios_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/historial_precio_provider.dart';

class AdminHistorialPreciosScreen extends ConsumerWidget {
  const AdminHistorialPreciosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(historialPreciosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de precios')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(historialPreciosProvider.future),
        child: historialAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(child: Text('No se pudo cargar el historial')),
          data: (historial) {
            if (historial.isEmpty) {
              return const Center(
                child: Text('Aún no hay cambios de precio registrados', style: AppTextStyles.bodySecondary),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: historial.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final h = historial[index];
                final subio = h.precioNuevo > h.precioAnterior;

                return Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: subio
                          ? AppColors.error.withValues(alpha: 0.15)
                          : AppColors.success.withValues(alpha: 0.15),
                      child: Icon(
                        subio ? Icons.trending_up : Icons.trending_down,
                        color: subio ? AppColors.error : AppColors.success,
                      ),
                    ),
                    title: Text(h.motoNombre ?? 'Moto'),
                    subtitle: Text(
                      '\$${h.precioAnterior.toStringAsFixed(0)} → \$${h.precioNuevo.toStringAsFixed(0)}\n'
                      '${DateFormat('dd/MM/yyyy HH:mm').format(h.fecha)}'
                      '${h.usuarioNombre != null ? ' · ${h.usuarioNombre}' : ''}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}