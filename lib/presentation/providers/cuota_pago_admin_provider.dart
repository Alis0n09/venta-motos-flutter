// lib/presentation/providers/cuota_pago_admin_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/cuota_pago_remote_datasource.dart';
import '../../domain/model/cuota_pago.dart';

/// Cuotas de un financiamiento puntual, ordenadas por número de cuota.
final cuotasPorFinanciamientoProvider =
    FutureProvider.autoDispose.family<List<CuotaPago>, int>((ref, financiamientoId) async {
  final datasource = ref.watch(cuotaPagoDatasourceProvider);
  return datasource.getCuotas(financiamiento: financiamientoId);
});

class CuotaPagoAdminNotifier extends StateNotifier<AsyncValue<void>> {
  final CuotaPagoRemoteDatasource _datasource;
  final Ref _ref;

  CuotaPagoAdminNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  void _refrescar(int financiamientoId) {
    _ref.invalidate(cuotasPorFinanciamientoProvider(financiamientoId));
  }

  Future<bool> crear(Map<String, dynamic> payload, {required int financiamientoId}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.createCuota(payload);
      state = const AsyncValue.data(null);
      _refrescar(financiamientoId);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return false;
    }
  }

  Future<bool> editar(int id, Map<String, dynamic> payload, {required int financiamientoId}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.updateCuota(id, payload);
      state = const AsyncValue.data(null);
      _refrescar(financiamientoId);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado. Intenta de nuevo.', st);
      return false;
    }
  }

  /// Atajo para marcar una cuota como pagada hoy.
  Future<bool> marcarPagada(CuotaPago cuota, {required int financiamientoId}) {
    final hoy = DateTime.now();
    final fecha = '${hoy.year.toString().padLeft(4, '0')}-'
        '${hoy.month.toString().padLeft(2, '0')}-'
        '${hoy.day.toString().padLeft(2, '0')}';
    return editar(
      cuota.id,
      {'estado': 'pagada', 'fecha_pago': fecha},
      financiamientoId: financiamientoId,
    );
  }

  Future<bool> eliminar(int id, {required int financiamientoId}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.deleteCuota(id);
      state = const AsyncValue.data(null);
      _refrescar(financiamientoId);
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

final cuotaPagoAdminProvider = StateNotifierProvider<CuotaPagoAdminNotifier, AsyncValue<void>>((ref) {
  return CuotaPagoAdminNotifier(ref.watch(cuotaPagoDatasourceProvider), ref);
});