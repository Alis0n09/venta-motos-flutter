// lib/presentation/providers/proveedor_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/proveedor_remote_datasource.dart';
import 'proveedor_provider.dart';

class ProveedorAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final ProveedorRemoteDatasource _datasource;
  final Ref _ref;

  ProveedorAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createProveedor(payload);
      state = const AsyncValue.data(null);
      _ref.read(proveedorProvider.notifier).loadProveedores();
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
      await _datasource.updateProveedor(id, payload);
      state = const AsyncValue.data(null);
      _ref.read(proveedorProvider.notifier).loadProveedores();
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
      await _datasource.deleteProveedor(id);
      state = const AsyncValue.data(null);
      _ref.read(proveedorProvider.notifier).loadProveedores();
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

final proveedorAdminProvider =
    StateNotifierProvider.autoDispose<ProveedorAdminNotifier, AsyncValue<void>>((ref) {
  return ProveedorAdminNotifier(ref.watch(proveedorDatasourceProvider), ref);
});
