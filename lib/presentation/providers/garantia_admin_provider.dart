// lib/presentation/providers/garantia_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/garantia_remote_datasource.dart';
import '../../domain/model/garantia.dart';

final garantiasProvider = FutureProvider.autoDispose<List<Garantia>>((ref) async {
  final datasource = ref.watch(garantiaDatasourceProvider);
  return datasource.getGarantias();
});

class GarantiaAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final GarantiaRemoteDatasource _datasource;
  final Ref _ref;

  GarantiaAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createGarantia(payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(garantiasProvider);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }

  Future<bool> editar(int id, Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateGarantia(id, payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(garantiasProvider);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }

  Future<bool> eliminar(int id) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.deleteGarantia(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(garantiasProvider);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }
}

final garantiaAdminProvider = StateNotifierProvider<GarantiaAdminNotifier, AsyncValue<void>>((ref) {
  return GarantiaAdminNotifier(ref.watch(garantiaDatasourceProvider), ref);
});

final garantiasPorVentaProvider = FutureProvider.autoDispose.family<List<Garantia>, int>((ref, ventaId) async {
  final datasource = ref.watch(garantiaDatasourceProvider);
  return datasource.getGarantiasPorVenta(ventaId);
});