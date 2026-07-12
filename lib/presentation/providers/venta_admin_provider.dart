// lib/presentation/providers/venta_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/vendedor_remote_datasource.dart';
import '../../data/remote/api/venta_remote_datasource.dart';
import '../../domain/model/vendedor.dart';
import '../../domain/model/venta.dart';
import '../../domain/model/venta_admin.dart';

/// Listado completo de ventas, para el panel admin/vendedor.
final ventasAdminProvider = FutureProvider.autoDispose<List<Venta>>((ref) async {
  final datasource = ref.watch(ventaDatasourceProvider);
  return datasource.getVentas();
});

/// Detalle de una venta puntual, usado en el formulario de edición.
final ventaDetalleProvider = FutureProvider.autoDispose.family<VentaAdmin, int>((ref, id) async {
  final datasource = ref.watch(ventaDatasourceProvider);
  return datasource.getVenta(id);
});

/// Vendedores disponibles, para reasignar una venta.
final vendedoresParaVentaProvider = FutureProvider.autoDispose<List<Vendedor>>((ref) async {
  final datasource = ref.watch(vendedorDatasourceProvider);
  return datasource.getVendedores();
});

class VentaAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final VentaRemoteDatasource _datasource;
  final Ref _ref;

  VentaAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> editar(int id, Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateVenta(id, payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(ventasAdminProvider);
      _ref.invalidate(ventaDetalleProvider(id));
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return false;
    }
  }

  Future<bool> eliminar(int id) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.deleteVenta(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(ventasAdminProvider);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return false;
    }
  }
}

final ventaAdminProvider = StateNotifierProvider<VentaAdminNotifier, AsyncValue<void>>((ref) {
  return VentaAdminNotifier(ref.watch(ventaDatasourceProvider), ref);
});
