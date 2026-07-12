// lib/presentation/screens/compra/mis_compras_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/comprar_provider.dart';
import '../../providers/garantia_admin_provider.dart';

class MisComprasScreen extends ConsumerWidget {
  const MisComprasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comprasAsync = ref.watch(misComprasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis compras')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(misComprasProvider.future),
        child: comprasAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(
                child: Text('No se pudieron cargar tus compras', style: AppTextStyles.bodySecondary),
              ),
            ],
          ),
          data: (compras) => compras.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(child: Text('Todavía no tienes compras', style: AppTextStyles.bodySecondary)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: compras.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final venta = compras[index];
                    final unidades = venta.detalles.fold<int>(0, (sum, d) => sum + d.cantidad);

                    return Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      child: ExpansionTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.accent,
                          child: Icon(Icons.receipt_long, color: Colors.white),
                        ),
                        title: Text('Compra #${venta.id}'),
                        subtitle: Text(
                          '${DateFormat('dd/MM/yyyy HH:mm').format(venta.fechaVenta)} · '
                          '$unidades unidad(es) · ${venta.metodoPago}',
                        ),
                        trailing: Text(
                          '\$${venta.total.toStringAsFixed(0)}',
                          style: AppTextStyles.price,
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        children: [
                          const Divider(height: 1),
                          const SizedBox(height: 12),
                          for (final detalle in venta.detalles)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detalle.motoNombre,
                                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${detalle.cantidad} x \$${detalle.precioUnitario.toStringAsFixed(0)}',
                                          style: AppTextStyles.bodySecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text('\$${detalle.subtotal.toStringAsFixed(0)}', style: AppTextStyles.body),
                                ],
                              ),
                            ),
                          if (venta.vendedorNombre != null) ...[
                            const SizedBox(height: 8),
                            Text('Atendido por ${venta.vendedorNombre}', style: AppTextStyles.bodySecondary),
                          ],
                          const SizedBox(height: 12),
                          Consumer(
                            builder: (context, ref, _) {
                              final garantiasAsync = ref.watch(garantiasPorVentaProvider(venta.id));
                              return garantiasAsync.when(
                                loading: () => const SizedBox.shrink(),
                                error: (_, __) => const SizedBox.shrink(),
                                data: (garantias) {
                                  if (garantias.isEmpty) return const SizedBox.shrink();
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Divider(height: 20),
                                      Text('GARANTÍA', style: AppTextStyles.caption),
                                      const SizedBox(height: 6),
                                      for (final garantia in garantias)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.verified_user_outlined, size: 16, color: AppColors.accent),
                                              const SizedBox(width: 6),
                                              Text(
                                                '${garantia.tipo} · válida hasta ${DateFormat('dd/MM/yyyy').format(garantia.fechaFin)}',
                                                style: AppTextStyles.bodySecondary,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
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