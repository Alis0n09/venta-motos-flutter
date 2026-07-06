// lib/presentation/screens/compra/compra_exitosa_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/venta_admin.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class CompraExitosaScreen extends StatelessWidget {
  final VentaAdmin venta;

  const CompraExitosaScreen({super.key, required this.venta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compra confirmada'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 16),
                    Text('¡Gracias por tu compra!', style: AppTextStyles.heading1),
                    const SizedBox(height: 4),
                    Text(
                      'Orden #${venta.id} · ${DateFormat('dd/MM/yyyy HH:mm').format(venta.fechaVenta)}',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              const Divider(),
              const SizedBox(height: 12),

              Text('DETALLE DE LA COMPRA', style: AppTextStyles.caption),
              const SizedBox(height: 12),

              for (final detalle in venta.detalles)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(detalle.motoNombre, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
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

              const Divider(),
              const SizedBox(height: 8),

              _FilaResumen(label: 'Método de pago', valor: venta.metodoPago),
              if (venta.vendedorNombre != null)
                _FilaResumen(label: 'Atendido por', valor: venta.vendedorNombre!),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total pagado', style: AppTextStyles.heading2),
                  Text('\$${venta.total.toStringAsFixed(0)}', style: AppTextStyles.price.copyWith(fontSize: 22)),
                ],
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/mis-compras'),
                  child: const Text('Ver mis compras'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/catalogo'),
                  child: const Text('Seguir comprando'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilaResumen extends StatelessWidget {
  final String label;
  final String valor;

  const _FilaResumen({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySecondary),
          Text(valor, style: AppTextStyles.body),
        ],
      ),
    );
  }
}