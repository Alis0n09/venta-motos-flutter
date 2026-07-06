// lib/presentation/providers/direccion_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/direccion_remote_datasource.dart';
import 'direccion_provider.dart';

class DireccionAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final DireccionRemoteDatasource _datasource;
  final Ref _ref;

  DireccionAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createDireccion(payload);
      if (!mounted) return true;
      state = const AsyncValue.data(null);
      _ref.read(direccionProvider.notifier).loadDirecciones();
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
      await _datasource.updateDireccion(id, payload);
      if (!mounted) return true;
      state = const AsyncValue.data(null);
      _ref.read(direccionProvider.notifier).loadDirecciones();
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
      await _datasource.deleteDireccion(id);
      if (!mounted) return true;
      state = const AsyncValue.data(null);
      _ref.read(direccionProvider.notifier).loadDirecciones();
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

final direccionAdminProvider =
    StateNotifierProvider.autoDispose<DireccionAdminNotifier, AsyncValue<void>>((ref) {
  return DireccionAdminNotifier(ref.watch(direccionDatasourceProvider), ref);
});
