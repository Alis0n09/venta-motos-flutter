// lib/presentation/providers/resena_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/resena_remote_datasource.dart';
import '../../domain/model/resena.dart';

final resenasPorMotoProvider = FutureProvider.family<List<Resena>, int>((ref, motoId) async {
  final datasource = ref.watch(resenaDatasourceProvider);
  return datasource.getResenasPorMoto(motoId);
});

class ResenaFormNotifier extends StateNotifier<AsyncValue<void>> {
  final ResenaRemoteDatasource _datasource;
  final Ref _ref;

  ResenaFormNotifier(this._datasource, this._ref) : super(const AsyncValue.data(null));

  Future<bool> enviar({required int motoId, required int rating, required String comentario}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.crearResena(motoId: motoId, rating: rating, comentario: comentario);
      state = const AsyncValue.data(null);
      _ref.invalidate(resenasPorMotoProvider(motoId));
      return true;
    } on ApiException catch (e, st) {
      state = AsyncValue.error(e.message, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error('Error inesperado.', st);
      return false;
    }
  }

  Future<bool> eliminar({required int id, required int motoId}) async {
    state = const AsyncValue.loading();
    try {
      await _datasource.eliminarResena(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(resenasPorMotoProvider(motoId));
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

final resenaFormProvider = StateNotifierProvider<ResenaFormNotifier, AsyncValue<void>>((ref) {
  return ResenaFormNotifier(ref.watch(resenaDatasourceProvider), ref);
});