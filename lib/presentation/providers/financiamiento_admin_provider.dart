// lib/presentation/providers/financiamiento_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/financiamiento_remote_datasource.dart';
import '../../domain/model/financiamiento.dart';
import 'cuota_pago_admin_provider.dart';

/// Listado completo de financiamientos para el panel admin.
final financiamientosAdminProvider =
    FutureProvider.autoDispose.family<List<Financiamiento>, String?>((ref, estado) async {
  final datasource = ref.watch(financiamientoDatasourceProvider);
  return datasource.getFinanciamientos(estado: estado);
});

/// Financiamiento asociado a una venta puntual (null si la venta no tiene uno).
final financiamientoPorVentaProvider =
    FutureProvider.autoDispose.family<Financiamiento?, int>((ref, ventaId) async {
  final datasource = ref.watch(financiamientoDatasourceProvider);
  return datasource.getFinanciamientoPorVenta(ventaId);
});

class FinanciamientoAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final FinanciamientoRemoteDatasource _datasource;
  final Ref _ref;

  FinanciamientoAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  void _refrescar({int? ventaId}) {
    _ref.invalidate(financiamientosAdminProvider);
    if (ventaId != null) {
      _ref.invalidate(financiamientoPorVentaProvider(ventaId));
    }
  }

  Future<Financiamiento?> crear(Map<String, dynamic> payload, {required int ventaId}) async {
    state = const AsyncValue.loading();
    try {
      final creado = await _datasource.createFinanciamiento(payload);
      state = const AsyncValue.data(null);
      _refrescar(ventaId: ventaId);
      return creado;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return null;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return null;
    }
  }

  Future<bool> editar(int id, Map<String, dynamic> payload, {required int ventaId}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateFinanciamiento(id, payload);
      state = const AsyncValue.data(null);
      _refrescar(ventaId: ventaId);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return false;
    }
  }

  Future<bool> eliminar(int id, {required int ventaId}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.deleteFinanciamiento(id);
      state = const AsyncValue.data(null);
      _refrescar(ventaId: ventaId);
      // Las cuotas se eliminan en cascada en el backend; refrescamos su cache también.
      _ref.invalidate(cuotasPorFinanciamientoProvider(id));
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

final financiamientoAdminProvider =
    StateNotifierProvider<FinanciamientoAdminNotifier, AsyncValue<void>>((ref) {
  return FinanciamientoAdminNotifier(ref.watch(financiamientoDatasourceProvider), ref);
});