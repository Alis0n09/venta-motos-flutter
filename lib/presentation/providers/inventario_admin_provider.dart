// lib/presentation/providers/inventario_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/inventario_remote_datasource.dart';
import 'catalog_provider.dart';
import 'inventario_provider.dart';

// El stock de Moto se calcula en el backend a partir de Inventario, así que
// cada CRUD exitoso debe refrescar los providers que muestran ese stock en
// catálogo/detalle, o quedan mostrando datos viejos hasta reiniciar la app.
void _refrescarStockDeMotos(Ref ref) {
  ref.invalidate(recomendadasProvider);
  ref.read(catalogProvider.notifier).loadMotos();
  ref.invalidate(motoDetailProvider);
}

class InventarioAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final InventarioRemoteDatasource _datasource;
  final Ref _ref;

  InventarioAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createInventario(payload);
      if (!mounted) return true;
      state = const AsyncValue.data(null);
      _ref.read(inventarioProvider.notifier).loadInventarios();
      _refrescarStockDeMotos(_ref);
      return true;
    } on ApiException catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }
  }

  Future<bool> editar(int id, Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateInventario(id, payload);
      if (!mounted) return true;
      state = const AsyncValue.data(null);
      _ref.read(inventarioProvider.notifier).loadInventarios();
      _refrescarStockDeMotos(_ref);
      return true;
    } on ApiException catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }
  }

  Future<bool> eliminar(int id) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.deleteInventario(id);
      if (!mounted) return true;
      state = const AsyncValue.data(null);
      _ref.read(inventarioProvider.notifier).loadInventarios();
      _refrescarStockDeMotos(_ref);
      return true;
    } on ApiException catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }
  }
}

final inventarioAdminProvider =
    StateNotifierProvider.autoDispose<InventarioAdminNotifier, AsyncValue<void>>((ref) {
  return InventarioAdminNotifier(ref.watch(inventarioDatasourceProvider), ref);
});
