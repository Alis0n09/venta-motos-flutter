// lib/presentation/screens/compra/carrito_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/carrito_provider.dart';
import '../../providers/comprar_provider.dart';

class CarritoScreen extends ConsumerStatefulWidget {
  const CarritoScreen({super.key});

  @override
  ConsumerState<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends ConsumerState<CarritoScreen> {
  String _metodoPago = 'efectivo';

  Future<void> _confirmarCompra() async {
    final items = ref.read(carritoProvider);
    final venta = await ref.read(comprarProvider.notifier).confirmar(
          metodoPago: _metodoPago,
          items: items,
        );

    if (!mounted) return;

    if (venta != null) {
      context.go('/compra-exitosa', extra: venta);
    } else {
      final error = ref.read(comprarProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error?.toString() ?? 'No se pudo procesar la compra'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(carritoProvider);
    final total = ref.watch(carritoTotalProvider);
    final comprarState = ref.watch(comprarProvider);
    final isLoading = comprarState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi carrito')),
      body: items.isEmpty
          ? const Center(
              child: Text('Tu carrito está vacío', style: AppTextStyles.bodySecondary),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text('${item.marcaNombre} ${item.modelo}'),
                    subtitle: Text('\$${item.precioUnitario.toStringAsFixed(0)} c/u'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: isLoading
                              ? null
                              : () => ref
                                  .read(carritoProvider.notifier)
                                  .actualizarCantidad(item.motoId, item.cantidad - 1),
                        ),
                        Text('${item.cantidad}', style: AppTextStyles.body),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: isLoading || item.cantidad >= item.stockDisponible
                              ? null
                              : () => ref
                                  .read(carritoProvider.notifier)
                                  .actualizarCantidad(item.motoId, item.cantidad + 1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error),
                          onPressed: isLoading
                              ? null
                              : () => ref.read(carritoProvider.notifier).quitar(item.motoId),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('MÉTODO DE PAGO', style: AppTextStyles.caption),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _metodoPago,
                      items: const [
                        DropdownMenuItem(value: 'efectivo', child: Text('Efectivo')),
                        DropdownMenuItem(value: 'transferencia', child: Text('Transferencia')),
                        DropdownMenuItem(value: 'tarjeta', child: Text('Tarjeta')),
                        DropdownMenuItem(value: 'credito', child: Text('Crédito')),
                      ],
                      onChanged: isLoading ? null : (v) => setState(() => _metodoPago = v!),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: AppTextStyles.heading2),
                        Text('\$${total.toStringAsFixed(0)}', style: AppTextStyles.price.copyWith(fontSize: 22)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: isLoading ? null : _confirmarCompra,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Confirmar compra'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}