// lib/presentation/providers/inventario_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/inventario_remote_datasource.dart';
import 'inventario_provider.dart';

class InventarioAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final InventarioRemoteDatasource _datasource;
  final Ref _ref;

  InventarioAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createInventario(payload);
      state = const AsyncValue.data(null);
      _ref.read(inventarioProvider.notifier).loadInventarios();
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }
  }

  Future<bool> editar(int id, Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateInventario(id, payload);
      state = const AsyncValue.data(null);
      _ref.read(inventarioProvider.notifier).loadInventarios();
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }
  }

  Future<bool> eliminar(int id) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.deleteInventario(id);
      state = const AsyncValue.data(null);
      _ref.read(inventarioProvider.notifier).loadInventarios();
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }
  }
}

final inventarioAdminProvider = StateNotifierProvider<InventarioAdminNotifier, AsyncValue<void>>((ref) {
  return InventarioAdminNotifier(ref.watch(inventarioDatasourceProvider), ref);
});
