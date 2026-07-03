// lib/presentation/providers/moto_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/moto_remote_datasource.dart';
import 'catalog_provider.dart';

class MotoAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final MotoRemoteDatasource _datasource;
  final Ref _ref;

  MotoAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createMoto(payload);
      state = const AsyncValue.data(null);
      _ref.read(catalogProvider.notifier).loadMotos();
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return false;
    }
  }

  Future<bool> editar(int id, Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateMoto(id, payload);
      state = const AsyncValue.data(null);
      _ref.read(catalogProvider.notifier).loadMotos();
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
      await _datasource.deleteMoto(id);
      state = const AsyncValue.data(null);
      _ref.read(catalogProvider.notifier).loadMotos();
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

final motoAdminProvider = StateNotifierProvider<MotoAdminNotifier, AsyncValue<void>>((ref) {
  return MotoAdminNotifier(ref.watch(motoDatasourceProvider), ref);
});