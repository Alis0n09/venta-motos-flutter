// lib/presentation/providers/sucursal_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/sucursal_remote_datasource.dart';
import 'sucursal_provider.dart';

class SucursalAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final SucursalRemoteDatasource _datasource;
  final Ref _ref;

  SucursalAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createSucursal(payload);
      state = const AsyncValue.data(null);
      _ref.read(sucursalProvider.notifier).loadSucursales();
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
      await _datasource.updateSucursal(id, payload);
      state = const AsyncValue.data(null);
      _ref.read(sucursalProvider.notifier).loadSucursales();
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
      await _datasource.deleteSucursal(id);
      state = const AsyncValue.data(null);
      _ref.read(sucursalProvider.notifier).loadSucursales();
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

final sucursalAdminProvider = StateNotifierProvider<SucursalAdminNotifier, AsyncValue<void>>((ref) {
  return SucursalAdminNotifier(ref.watch(sucursalDatasourceProvider), ref);
});
