import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/notificacion_cliente_remote_datasource.dart';
import '../../domain/model/notificacion_cliente.dart';

/// Notificaciones del cliente autenticado.
final misNotificacionesProvider = FutureProvider.autoDispose<List<NotificacionCliente>>((ref) async {
  final datasource = ref.watch(notificacionClienteDatasourceProvider);
  return datasource.getMisNotificaciones();
});

/// Cantidad de notificaciones no leídas (útil para un badge en Perfil).
final notificacionesNoLeidasProvider = Provider.autoDispose<int>((ref) {
  final notificaciones = ref.watch(misNotificacionesProvider).valueOrNull ?? [];
  return notificaciones.where((n) => !n.leido).length;
});

class NotificacionClienteNotifier extends StateNotifier<AsyncValue<void>> {
  final NotificacionClienteRemoteDatasource _datasource;
  final Ref _ref;

  NotificacionClienteNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> marcarLeida(int id) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.marcarLeida(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(misNotificacionesProvider);
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

final notificacionClienteProvider =
    StateNotifierProvider<NotificacionClienteNotifier, AsyncValue<void>>((ref) {
  return NotificacionClienteNotifier(ref.watch(notificacionClienteDatasourceProvider), ref);
});