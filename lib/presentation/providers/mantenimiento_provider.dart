// lib/presentation/providers/mantenimiento_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/mantenimiento_remote_datasource.dart';
import '../../domain/model/cliente_mini.dart';
import '../../domain/model/mantenimiento.dart';

final mantenimientosProvider = FutureProvider.autoDispose<List<Mantenimiento>>((ref) async {
  final datasource = ref.watch(mantenimientoDatasourceProvider);
  return datasource.getMantenimientos();
});

final clientesMiniProvider = FutureProvider.autoDispose<List<ClienteMini>>((ref) async {
  final datasource = ref.watch(mantenimientoDatasourceProvider);
  return datasource.getClientes();
});

class MantenimientoFormNotifier extends StateNotifier<AsyncValue<void>> {
  final MantenimientoRemoteDatasource _datasource;
  final Ref _ref;

  MantenimientoFormNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> crear(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.crearMantenimiento(payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(mantenimientosProvider);
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
      await _datasource.editarMantenimiento(id, payload);
      state = const AsyncValue.data(null);
      _ref.invalidate(mantenimientosProvider);
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
      await _datasource.eliminarMantenimiento(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(mantenimientosProvider);
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

final mantenimientoFormProvider = StateNotifierProvider<MantenimientoFormNotifier, AsyncValue<void>>((ref) {
  return MantenimientoFormNotifier(ref.watch(mantenimientoDatasourceProvider), ref);
});