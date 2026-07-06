// lib/presentation/providers/comprar_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/venta_remote_datasource.dart';
import '../../domain/model/carrito_item.dart';
import '../../domain/model/venta_admin.dart';
import 'carrito_provider.dart';
import 'catalog_provider.dart';
import 'inventario_provider.dart';

class ComprarNotifier extends StateNotifier<AsyncValue<VentaAdmin?>> {
  final VentaRemoteDatasource _datasource;
  final Ref _ref;

  ComprarNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<VentaAdmin?> confirmar({required String metodoPago, required List<CarritoItem> items}) async {
    if (items.isEmpty) return null;

    state = const AsyncValue.loading();
    try {
      final venta = await _datasource.comprar(
        metodoPago: metodoPago,
        items: items
            .map((i) => {'moto_id': i.motoId, 'cantidad': i.cantidad})
            .toList(),
      );
      if (!mounted) return venta;
      state = AsyncValue.data(venta);
      _ref.read(carritoProvider.notifier).limpiar();
      _ref.invalidate(misComprasProvider);
      _ref.invalidate(recomendadasProvider);
      _ref.read(catalogProvider.notifier).loadMotos();
      _ref.invalidate(motoDetailProvider);
      _ref.invalidate(inventarioProvider);
      return venta;
    } on ApiException catch (e, st) {
      if (!mounted) return null;
      state = AsyncValue.error(e.message, st);
      return null;
    } catch (e, st) {
      if (!mounted) return null;
      state = AsyncValue.error('Error inesperado al procesar la compra.', st);
      return null;
    }
  }
}

final comprarProvider = StateNotifierProvider<ComprarNotifier, AsyncValue<VentaAdmin?>>((ref) {
  return ComprarNotifier(ref.watch(ventaDatasourceProvider), ref);
});

final misComprasProvider = FutureProvider<List<VentaAdmin>>((ref) async {
  final datasource = ref.watch(ventaDatasourceProvider);
  return datasource.getMisCompras();
});
