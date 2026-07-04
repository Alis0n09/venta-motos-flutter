// lib/presentation/providers/carrito_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/carrito_item.dart';
import '../../domain/model/moto.dart';

class CarritoNotifier extends StateNotifier<List<CarritoItem>> {
  CarritoNotifier() : super(const []);

  void agregarMoto(Moto moto, {int cantidad = 1}) {
    final index = state.indexWhere((i) => i.motoId == moto.id);
    if (index == -1) {
      state = [
        ...state,
        CarritoItem(
          motoId: moto.id,
          marcaNombre: moto.marcaNombre,
          modelo: moto.modelo,
          precioUnitario: moto.precio,
          stockDisponible: moto.stock,
          cantidad: cantidad,
        ),
      ];
      return;
    }

    final actual = state[index];
    final nuevaCantidad = (actual.cantidad + cantidad).clamp(1, actual.stockDisponible);
    _actualizarEnIndice(index, actual.copyWith(cantidad: nuevaCantidad));
  }

  void actualizarCantidad(int motoId, int cantidad) {
    final index = state.indexWhere((i) => i.motoId == motoId);
    if (index == -1) return;
    final actual = state[index];
    final nuevaCantidad = cantidad.clamp(1, actual.stockDisponible);
    _actualizarEnIndice(index, actual.copyWith(cantidad: nuevaCantidad));
  }

  void quitar(int motoId) {
    state = state.where((i) => i.motoId != motoId).toList();
  }

  void limpiar() {
    state = const [];
  }

  void _actualizarEnIndice(int index, CarritoItem item) {
    final nuevaLista = [...state];
    nuevaLista[index] = item;
    state = nuevaLista;
  }
}

final carritoProvider = StateNotifierProvider<CarritoNotifier, List<CarritoItem>>((ref) {
  return CarritoNotifier();
});

final carritoTotalProvider = Provider<double>((ref) {
  final items = ref.watch(carritoProvider);
  return items.fold<double>(0, (sum, i) => sum + i.subtotal);
});

final carritoCantidadProvider = Provider<int>((ref) {
  final items = ref.watch(carritoProvider);
  return items.fold<int>(0, (sum, i) => sum + i.cantidad);
});
