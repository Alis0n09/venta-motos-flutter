import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/auth_remote_datasource.dart';

class PasswordResetNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRemoteDatasource _datasource;

  PasswordResetNotifier(this._datasource) : super(const AsyncValue.data(null));

  Future<bool> solicitar(String username) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.solicitarResetPassword(username);
      state = const AsyncValue.data(null);
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }

  Future<bool> confirmar({
    required String codigo,
    required String newPassword,
    required String newPassword2,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.confirmarResetPassword(
        codigo: codigo,
        newPassword: newPassword,
        newPassword2: newPassword2,
      );
      state = const AsyncValue.data(null);
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

final passwordResetProvider = StateNotifierProvider<PasswordResetNotifier, AsyncValue<void>>((ref) {
  return PasswordResetNotifier(ref.watch(authDatasourceProvider));
});