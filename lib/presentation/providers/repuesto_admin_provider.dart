import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/repuesto_remote_datasource.dart';
import '../../domain/model/repuesto.dart';

final repuestosProvider = FutureProvider.autoDispose<List<Repuesto>>((ref) async {
  final datasource = ref.watch(repuestoDatasourceProvider);
  return datasource.getRepuestos();
});

class RepuestoAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final RepuestoRemoteDatasource _datasource;
  final Ref _ref;

  RepuestoAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createRepuesto(payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(repuestosProvider);
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
      await _datasource.updateRepuesto(id, payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(repuestosProvider);
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
      await _datasource.deleteRepuesto(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(repuestosProvider);
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

final repuestoAdminProvider = StateNotifierProvider<RepuestoAdminNotifier, AsyncValue<void>>((ref) {
  return RepuestoAdminNotifier(ref.watch(repuestoDatasourceProvider), ref);
});