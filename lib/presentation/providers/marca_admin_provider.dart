// lib/presentation/providers/marca_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/marca_remote_datasource.dart';
import '../../domain/model/marca.dart';
import 'catalog_provider.dart';

/// Listado completo (incluye inactivas) para el panel admin.
final marcasAdminProvider = FutureProvider.autoDispose<List<Marca>>((ref) async {
  final datasource = ref.watch(marcaDatasourceProvider);
  return datasource.getMarcas(soloActivas: false);
});

class MarcaAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final MarcaRemoteDatasource _datasource;
  final Ref _ref;

  MarcaAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  void _refrescar() {
    _ref.invalidate(marcasAdminProvider);
    _ref.invalidate(marcasProvider);
  }

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createMarca(payload);
      state = const AsyncValue.data(null);
      _refrescar();
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
      await _datasource.updateMarca(id, payload);
      state = const AsyncValue.data(null);
      _refrescar();
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
      await _datasource.deleteMarca(id);
      state = const AsyncValue.data(null);
      _refrescar();
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

final marcaAdminProvider = StateNotifierProvider<MarcaAdminNotifier, AsyncValue<void>>((ref) {
  return MarcaAdminNotifier(ref.watch(marcaDatasourceProvider), ref);
});
