// lib/presentation/providers/sucursal_staff_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/sucursal_staff_remote_datasource.dart';
import 'sucursal_staff_provider.dart';

class SucursalStaffAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final SucursalStaffRemoteDatasource _datasource;
  final Ref _ref;

  SucursalStaffAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createSucursalStaff(payload);
      state = const AsyncValue.data(null);
      _ref.read(sucursalStaffProvider.notifier).loadAsignaciones();
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
      await _datasource.updateSucursalStaff(id, payload);
      state = const AsyncValue.data(null);
      _ref.read(sucursalStaffProvider.notifier).loadAsignaciones();
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
      await _datasource.deleteSucursalStaff(id);
      state = const AsyncValue.data(null);
      _ref.read(sucursalStaffProvider.notifier).loadAsignaciones();
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

final sucursalStaffAdminProvider =
    StateNotifierProvider.autoDispose<SucursalStaffAdminNotifier, AsyncValue<void>>((ref) {
  return SucursalStaffAdminNotifier(ref.watch(sucursalStaffDatasourceProvider), ref);
});
