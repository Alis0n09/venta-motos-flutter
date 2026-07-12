// lib/presentation/providers/categoria_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/categoria_remote_datasource.dart';
import 'catalog_provider.dart';

class CategoriaAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final CategoriaRemoteDatasource _datasource;
  final Ref _ref;

  CategoriaAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createCategoria(payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(categoriasProvider);
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
      await _datasource.updateCategoria(id, payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(categoriasProvider);
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
      await _datasource.deleteCategoria(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(categoriasProvider);
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

final categoriaAdminProvider = StateNotifierProvider<CategoriaAdminNotifier, AsyncValue<void>>((ref) {
  return CategoriaAdminNotifier(ref.watch(categoriaDatasourceProvider), ref);
});
