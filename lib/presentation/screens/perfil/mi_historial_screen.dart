// lib/presentation/screens/perfil/mi_historial_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/historial_cliente.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/historial_cliente_provider.dart';

class MiHistorialScreen extends ConsumerWidget {
  const MiHistorialScreen({super.key});

  IconData _iconoEvento(String tipoEvento) {
    switch (tipoEvento) {
      case 'mantenimiento':
        return Icons.build_outlined;
      case 'garantia':
        return Icons.verified_outlined;
      case 'resena':
        return Icons.star_outline;
      case 'financiamiento':
        return Icons.credit_score_outlined;
      default:
        return Icons.history;
    }
  }

  String _tituloEvento(String tipoEvento) {
    switch (tipoEvento) {
      case 'mantenimiento':
        return 'Mantenimiento agendado';
      case 'garantia':
        return 'Garantía registrada';
      case 'resena':
        return 'Reseña publicada';
      case 'financiamiento':
        return 'Financiamiento creado';
      default:
        return tipoEvento;
    }
  }

  /// Convierte snake_case a texto legible: "monto_financiado" → "Monto financiado".
  String _formatearClave(String clave) {
    final texto = clave.replaceAll('_', ' ');
    return texto[0].toUpperCase() + texto.substring(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(miHistorialProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi historial')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(miHistorialProvider.future),
        child: historialAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('No se pudo cargar tu historial', style: AppTextStyles.bodySecondary)),
            ],
          ),
          data: (historial) => historial.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(child: Text('Aún no tienes eventos registrados', style: AppTextStyles.bodySecondary)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: historial.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final h = historial[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.accentLight,
                          child: Icon(_iconoEvento(h.tipoEvento), color: AppColors.accent, size: 20),
                        ),
                        title: Text(_tituloEvento(h.tipoEvento), style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                        subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(h.fecha)),
                        children: [
                          if (h.detalle.isEmpty)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text('Sin detalles adicionales', style: AppTextStyles.bodySecondary),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: h.detalle.entries
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.only(bottom: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(_formatearClave(e.key), style: AppTextStyles.bodySecondary),
                                              const SizedBox(width: 12),
                                              Flexible(
                                                child: Text(
                                                  '${e.value}',
                                                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}