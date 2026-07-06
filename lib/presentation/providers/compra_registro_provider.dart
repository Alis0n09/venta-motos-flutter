// lib/presentation/providers/compra_registro_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/error/api_exception.dart';
import '../../data/remote/api/compra_remote_datasource.dart';
import '../../data/remote/api/detalle_compra_remote_datasource.dart';
import '../../data/remote/api/inventario_remote_datasource.dart';
import 'catalog_provider.dart';
import 'compra_provider.dart';
import 'inventario_provider.dart';

class LineaCompra {
  final int motoId;
  final String motoNombre;
  final int cantidad;
  final double precioCosto;

  const LineaCompra({
    required this.motoId,
    required this.motoNombre,
    required this.cantidad,
    required this.precioCosto,
  });
}

class LineaConError {
  final String motoNombre;
  final String mensaje;

  const LineaConError({required this.motoNombre, required this.mensaje});
}

/// Resultado de registrar una compra: la cabecera y los detalles ya quedaron
/// creados en el backend; esto solo informa qué líneas lograron actualizar
/// el stock en Inventario y cuáles no, para que el usuario pueda corregir
/// manualmente las que fallaron.
class CompraRegistroResultado {
  final List<String> motosActualizadas;
  final List<LineaConError> motosConError;

  const CompraRegistroResultado({
    required this.motosActualizadas,
    required this.motosConError,
  });

  bool get huboErrores => motosConError.isNotEmpty;
}

class CompraRegistroNotifier extends StateNotifier<AsyncValue<CompraRegistroResultado?>> {
  final CompraRemoteDatasource _compraDatasource;
  final DetalleCompraRemoteDatasource _detalleDatasource;
  final InventarioRemoteDatasource _inventarioDatasource;
  final Ref _ref;

  CompraRegistroNotifier(
    this._compraDatasource,
    this._detalleDatasource,
    this._inventarioDatasource,
    this._ref,
  ) : super(const AsyncValue.data(null));

  Future<bool> registrarCompra({
    required int proveedorId,
    required int sucursalId,
    required List<LineaCompra> lineas,
  }) async {
    state = const AsyncValue.loading();

    // La compra (cabecera) y sus detalles son todo o nada: si algo falla acá,
    // la compra no quedó registrada y no tiene sentido tocar el inventario.
    try {
      final total = lineas.fold<double>(0, (acc, l) => acc + (l.cantidad * l.precioCosto));

      final compra = await _compraDatasource.createCompra({
        'proveedor': proveedorId,
        'sucursal_destino': sucursalId,
        'total': total,
      });
      if (!mounted) return true;

      for (final linea in lineas) {
        await _detalleDatasource.createDetalleCompra({
          'compra': compra.id,
          'moto': linea.motoId,
          'cantidad': linea.cantidad,
          'precio_costo': linea.precioCosto,
        });
        if (!mounted) return true;
      }
    } on ApiException catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      if (!mounted) return false;
      state = AsyncValue.error(const ApiException('Error inesperado. Intenta de nuevo.'), st);
      return false;
    }

    // A partir de acá la compra ya quedó registrada. Actualizar el stock de
    // cada línea es independiente: si una falla, no debe ocultar ni revertir
    // el resto, sino quedar reportada para corregirla manualmente.
    final motosActualizadas = <String>[];
    final motosConError = <LineaConError>[];

    for (final linea in lineas) {
      try {
        final existentes = await _inventarioDatasource.getInventarios(
          moto: linea.motoId,
          sucursal: sucursalId,
        );
        if (!mounted) return true;
        if (existentes.isNotEmpty) {
          final actual = existentes.first;
          await _inventarioDatasource.updateInventario(actual.id, {
            'cantidad': actual.cantidad + linea.cantidad,
          });
        } else {
          await _inventarioDatasource.createInventario({
            'moto': linea.motoId,
            'sucursal': sucursalId,
            'cantidad': linea.cantidad,
            'ubicacion_bodega': '',
          });
        }
        if (!mounted) return true;
        motosActualizadas.add(linea.motoNombre);
      } on ApiException catch (e) {
        if (!mounted) return true;
        motosConError.add(LineaConError(motoNombre: linea.motoNombre, mensaje: e.message));
      } catch (_) {
        if (!mounted) return true;
        motosConError.add(
          LineaConError(
            motoNombre: linea.motoNombre,
            mensaje: 'Error inesperado al actualizar el stock.',
          ),
        );
      }
    }

    state = AsyncValue.data(
      CompraRegistroResultado(motosActualizadas: motosActualizadas, motosConError: motosConError),
    );
    _ref.read(compraProvider.notifier).loadCompras();
    _ref.read(inventarioProvider.notifier).loadInventarios();
    _ref.invalidate(recomendadasProvider);
    _ref.read(catalogProvider.notifier).loadMotos();
    _ref.invalidate(motoDetailProvider);
    return true;
  }
}

final compraRegistroProvider = StateNotifierProvider.autoDispose<CompraRegistroNotifier,
    AsyncValue<CompraRegistroResultado?>>((ref) {
  return CompraRegistroNotifier(
    ref.watch(compraDatasourceProvider),
    ref.watch(detalleCompraDatasourceProvider),
    ref.watch(inventarioDatasourceProvider),
    ref,
  );
});
