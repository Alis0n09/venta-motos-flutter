// lib/presentation/screens/inventario/inventario_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/inventario.dart';
import '../../../domain/model/moto.dart';
import '../../../domain/model/sucursal.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../providers/inventario_admin_provider.dart';
import '../../providers/inventario_provider.dart';
import '../../providers/sucursal_provider.dart';

// Máximo de referencia para la barra de progreso de stock: a esta cantidad
// (o más) la barra se ve llena. Fácil de ajustar si cambia la política de stock.
const _stockMaximoReferencia = 30;

String _formatearPrecio(double precio) => NumberFormat('#,##0').format(precio);

Color _colorParaStock(int stock) {
  if (stock == 0) return AppColors.error;
  if (stock < 10) return AppColors.warning;
  return AppColors.success;
}

String _textoParaStock(int stock) {
  if (stock == 0) return 'Agotada';
  if (stock < 10) return 'Stock bajo';
  return 'Activa';
}

Widget _placeholderMotoImagen() {
  return Container(
    color: AppColors.background,
    child: const Icon(Icons.two_wheeler, color: AppColors.textSecondary),
  );
}

Widget _imagenMoto(String? imagenUrl) {
  if (imagenUrl != null && imagenUrl.isNotEmpty) {
    return Image.network(
      imagenUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholderMotoImagen(),
    );
  }
  return _placeholderMotoImagen();
}

Widget _buildBarraStock(int stock) {
  final progreso = (stock / _stockMaximoReferencia).clamp(0.0, 1.0);
  return ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: LinearProgressIndicator(
      value: progreso,
      minHeight: 6,
      backgroundColor: AppColors.border,
      valueColor: AlwaysStoppedAnimation<Color>(_colorParaStock(stock)),
    ),
  );
}

Widget _buildBadgeStock(int stock) {
  final color = _colorParaStock(stock);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      _textoParaStock(stock),
      style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11),
    ),
  );
}

class InventarioListScreen extends ConsumerStatefulWidget {
  const InventarioListScreen({super.key});

  @override
  ConsumerState<InventarioListScreen> createState() =>
      _InventarioListScreenState();
}

class _InventarioListScreenState extends ConsumerState<InventarioListScreen> {
  final _searchController = TextEditingController();
  final _cantidadMinController = TextEditingController();
  final _cantidadMaxController = TextEditingController();

  // Modo de vista de la pantalla: null = "Todas" (agregado por moto, entre
  // todas las sucursales); un id = vista actual por registro de Inventario,
  // filtrada a esa sucursal.
  int? _sucursalVistaId;

  // Filtro de marca del modo agregado (null = "Todas"). Es puramente local:
  // la lista completa de motos ya está cargada y se filtra en el cliente.
  String? _marcaFiltroAgregado;

  @override
  void dispose() {
    _searchController.dispose();
    _cantidadMinController.dispose();
    _cantidadMaxController.dispose();
    super.dispose();
  }

  List<Moto> _filtrarMotosAgregado(List<Moto> motos) {
    var resultado = motos;
    if (_marcaFiltroAgregado != null) {
      resultado = resultado
          .where((m) => m.marcaNombre == _marcaFiltroAgregado)
          .toList();
    }
    final texto = _searchController.text.trim().toLowerCase();
    if (texto.isNotEmpty) {
      resultado = resultado
          .where((m) =>
              m.modelo.toLowerCase().contains(texto) ||
              m.marcaNombre.toLowerCase().contains(texto))
          .toList();
    }
    return resultado;
  }

  Widget _buildChipMarca(String label, bool seleccionada, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label),
      selected: seleccionada,
      onSelected: (_) => onTap(),
      labelStyle:
          TextStyle(color: seleccionada ? Colors.white : AppColors.textPrimary),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
            color: seleccionada ? AppColors.primary : AppColors.border),
      ),
    );
  }

  Widget _buildChipsMarca(List<Moto> motos) {
    final marcas = motos.map((m) => m.marcaNombre).toSet().toList()..sort();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChipMarca('Todas', _marcaFiltroAgregado == null, () {
            setState(() => _marcaFiltroAgregado = null);
          }),
          for (final marca in marcas) ...[
            const SizedBox(width: 8),
            _buildChipMarca(marca, _marcaFiltroAgregado == marca, () {
              setState(() => _marcaFiltroAgregado = marca);
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectorSucursal(AsyncValue<List<Sucursal>> sucursalesAsync) {
    return sucursalesAsync.when(
      data: (sucursales) {
        final actual = sucursales.where((s) => s.id == _sucursalVistaId);
        final etiqueta = _sucursalVistaId == null
            ? 'Todas'
            : (actual.isNotEmpty ? actual.first.nombre : 'Todas');

        return PopupMenuButton<int?>(
          initialValue: _sucursalVistaId,
          onSelected: (value) => setState(() => _sucursalVistaId = value),
          itemBuilder: (context) => [
            const PopupMenuItem<int?>(value: null, child: Text('Todas')),
            ...sucursales.map(
              (s) => PopupMenuItem<int?>(value: s.id, child: Text(s.nombre)),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.store_outlined,
                    size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  'Sucursal: $etiqueta',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.arrow_drop_down,
                    size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 36,
        width: 120,
        child: Center(child: LinearProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _aplicarFiltroCantidad() {
    ref.read(inventarioProvider.notifier).filtrarPorCantidad(
          min: int.tryParse(_cantidadMinController.text),
          max: int.tryParse(_cantidadMaxController.text),
        );
  }

  Future<void> _confirmarEliminar(int id, String motoNombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar registro?'),
        content: Text(
            'Vas a eliminar "$motoNombre" de este inventario. Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    final exito = await ref.read(inventarioAdminProvider.notifier).eliminar(id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              exito ? 'Registro eliminado' : 'No se pudo eliminar el registro'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _abrirDesglosePorSucursal(Moto moto) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _DesgloseSucursalSheet(moto: moto),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inventarioState = ref.watch(inventarioProvider);
    final adminState = ref.watch(inventarioAdminProvider);
    final authState = ref.watch(authProvider);
    final motosAsync = ref.watch(recomendadasProvider);
    final sucursalState = ref.watch(sucursalProvider);
    final sucursalesTodasAsync = ref.watch(sucursalesTodasProvider);
    final puedeGestionar = authState.isAdmin || authState.isBodeguero;
    final modoAgregado = _sucursalVistaId == null;

    final motosFiltradas = motosAsync.valueOrNull != null
        ? _filtrarMotosAgregado(motosAsync.valueOrNull!)
        : const <Moto>[];
    final totalItems = modoAgregado
        ? motosFiltradas.length
        : inventarioState.inventarios.length;
    final stockBajoCount = modoAgregado
        ? motosFiltradas.where((m) => m.stock > 0 && m.stock < 10).length
        : inventarioState.inventarios
            .where((i) => i.cantidad > 0 && i.cantidad < 10)
            .length;
    final motosPorId = {
      for (final m in motosAsync.valueOrNull ?? const <Moto>[]) m.id: m,
    };

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(inventarioProvider.notifier).loadInventarios(),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PANEL ADMIN',
                            style: AppTextStyles.caption
                                .copyWith(color: AppColors.accent)),
                        const SizedBox(height: 4),
                        Text('Inventario', style: AppTextStyles.heading1),
                        const SizedBox(height: 4),
                        Text(
                          '$totalItems motos · $stockBajoCount con stock bajo',
                          style: AppTextStyles.bodySecondary,
                        ),
                      ],
                    ),
                  ),
                  if (puedeGestionar) ...[
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => context.push('/inventario/nuevo'),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                            color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por moto o sucursal...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(inventarioProvider.notifier).buscar('');
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (value) {
                  if (!modoAgregado)
                    ref.read(inventarioProvider.notifier).buscar(value);
                },
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildSelectorSucursal(sucursalesTodasAsync),
              ),
              const SizedBox(height: 16),
              if (!modoAgregado) ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: inventarioState.sucursalSeleccionada,
                        decoration:
                            const InputDecoration(labelText: 'Sucursal'),
                        isExpanded: true,
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text('Todas',
                                overflow: TextOverflow.ellipsis, maxLines: 1),
                          ),
                          ...sucursalState.sucursales.map(
                            (s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(s.nombre,
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                          ),
                        ],
                        onChanged: (v) => ref
                            .read(inventarioProvider.notifier)
                            .filtrarPorSucursal(v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: motosAsync.when(
                        data: (motos) => DropdownButtonFormField<int>(
                          initialValue: inventarioState.motoSeleccionada,
                          decoration: const InputDecoration(labelText: 'Moto'),
                          isExpanded: true,
                          items: [
                            const DropdownMenuItem<int>(
                              value: null,
                              child: Text('Todas',
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                            ),
                            ...motos.map(
                              (m) => DropdownMenuItem(
                                value: m.id,
                                child: Text(
                                  '${m.marcaNombre} ${m.modelo}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (v) => ref
                              .read(inventarioProvider.notifier)
                              .filtrarPorMoto(v),
                        ),
                        loading: () => const LinearProgressIndicator(),
                        error: (_, __) => const Text('Error'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cantidadMinController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Cantidad mín.'),
                        onSubmitted: (_) => _aplicarFiltroCantidad(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _cantidadMaxController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Cantidad máx.'),
                        onSubmitted: (_) => _aplicarFiltroCantidad(),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      tooltip: 'Aplicar filtro de cantidad',
                      icon: const Icon(Icons.filter_alt_outlined,
                          color: AppColors.accent),
                      onPressed: _aplicarFiltroCantidad,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('${inventarioState.inventarios.length} resultados',
                    style: AppTextStyles.bodySecondary),
                const SizedBox(height: 12),
                if (inventarioState.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (inventarioState.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                        child: Text(inventarioState.error!,
                            style: AppTextStyles.bodySecondary)),
                  )
                else if (inventarioState.inventarios.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Text('No se encontraron registros de inventario',
                          style: AppTextStyles.bodySecondary),
                    ),
                  )
                else
                  for (final item in inventarioState.inventarios) ...[
                    Card(
                      margin: EdgeInsets.zero,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => context
                            .push('/inventario/${item.id}/editar', extra: item),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: _imagenMoto(
                                          motosPorId[item.moto]?.imagenUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.motoNombre,
                                          style: AppTextStyles.body.copyWith(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${item.sucursalNombre}'
                                          '${(item.ubicacionBodega != null && item.ubicacionBodega!.isNotEmpty) ? ' · ${item.ubicacionBodega}' : ''}',
                                          style: AppTextStyles.bodySecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (motosPorId[item.moto] != null)
                                        Text(
                                          '\$${_formatearPrecio(motosPorId[item.moto]!.precio)}',
                                          style: AppTextStyles.price,
                                        ),
                                      if (puedeGestionar) ...[
                                        const SizedBox(height: 2),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              icon: const Icon(
                                                  Icons.edit_outlined,
                                                  size: 20,
                                                  color:
                                                      AppColors.textSecondary),
                                              onPressed: () => context.push(
                                                  '/inventario/${item.id}/editar',
                                                  extra: item),
                                            ),
                                            const SizedBox(width: 8),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              icon: const Icon(
                                                  Icons.delete_outline,
                                                  size: 20,
                                                  color: AppColors.error),
                                              onPressed: adminState.isLoading
                                                  ? null
                                                  : () => _confirmarEliminar(
                                                      item.id, item.motoNombre),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildBarraStock(item.cantidad)),
                                  const SizedBox(width: 8),
                                  Text('${item.cantidad} u.',
                                      style: AppTextStyles.bodySecondary),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _buildBadgeStock(item.cantidad),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
              ] else
                motosAsync.when(
                  data: (motos) {
                    final filtradas = _filtrarMotosAgregado(motos);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildChipsMarca(motos),
                        const SizedBox(height: 20),
                        Text('${filtradas.length} resultados',
                            style: AppTextStyles.bodySecondary),
                        const SizedBox(height: 12),
                        if (filtradas.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 60),
                            child: Center(
                              child: Text('No se encontraron motos',
                                  style: AppTextStyles.bodySecondary),
                            ),
                          )
                        else
                          for (final moto in filtradas) ...[
                            _MotoAgregadaTile(
                              moto: moto,
                              onTap: () => _abrirDesglosePorSucursal(moto),
                            ),
                            const SizedBox(height: 10),
                          ],
                      ],
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Text('No se pudieron cargar las motos',
                          style: AppTextStyles.bodySecondary),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tarjeta de una Moto con su stock ya agregado entre todas las sucursales,
/// usada en el modo "Todas" del selector de sucursal.
class _MotoAgregadaTile extends StatelessWidget {
  final Moto moto;
  final VoidCallback onTap;

  const _MotoAgregadaTile({required this.moto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: _imagenMoto(moto.imagenUrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${moto.marcaNombre} ${moto.modelo}',
                          style: AppTextStyles.body
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text('${moto.cilindraje} cc · ${moto.anio}',
                            style: AppTextStyles.bodySecondary),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$${_formatearPrecio(moto.precio)}',
                    style: AppTextStyles.price,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildBarraStock(moto.stock)),
                  const SizedBox(width: 8),
                  Text('${moto.stock} u.', style: AppTextStyles.bodySecondary),
                ],
              ),
              const SizedBox(height: 8),
              _buildBadgeStock(moto.stock),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet con el desglose por sucursal (registros reales de Inventario)
/// de una Moto puntual, abierto desde su tarjeta en el modo "Todas".
class _DesgloseSucursalSheet extends ConsumerWidget {
  final Moto moto;

  const _DesgloseSucursalSheet({required this.moto});

  Future<void> _confirmarEliminar(
      BuildContext context, WidgetRef ref, Inventario item) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar registro?'),
        content: Text(
          'Vas a eliminar el registro de "${item.sucursalNombre}" para esta moto. '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    final exito =
        await ref.read(inventarioAdminProvider.notifier).eliminar(item.id);
    if (exito) ref.invalidate(desgloseInventarioProvider(item.moto));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              exito ? 'Registro eliminado' : 'No se pudo eliminar el registro'),
          backgroundColor: exito ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final desgloseAsync = ref.watch(desgloseInventarioProvider(moto.id));
    final authState = ref.watch(authProvider);
    final puedeGestionar = authState.isAdmin || authState.isBodeguero;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESGLOSE POR SUCURSAL',
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.accent),
                      ),
                      Text('${moto.marcaNombre} ${moto.modelo}',
                          style: AppTextStyles.heading2),
                    ],
                  ),
                ),
                if (puedeGestionar)
                  IconButton(
                    tooltip: 'Agregar en una sucursal nueva',
                    icon: const Icon(Icons.add_circle_outline,
                        color: AppColors.accent),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.push('/inventario/nuevo', extra: moto.id);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: desgloseAsync.when(
                data: (registros) {
                  if (registros.isEmpty) {
                    return Center(
                      child: Text(
                        'Esta moto no tiene stock en ninguna sucursal',
                        style: AppTextStyles.bodySecondary,
                      ),
                    );
                  }
                  return ListView.separated(
                    controller: scrollController,
                    itemCount: registros.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = registros[index];
                      return Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          title: Text(item.sucursalNombre),
                          subtitle: Text(
                            'Cantidad: ${item.cantidad}'
                            '${(item.ubicacionBodega != null && item.ubicacionBodega!.isNotEmpty) ? ' · ${item.ubicacionBodega}' : ''}',
                          ),
                          trailing: puedeGestionar
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined,
                                          color: AppColors.textSecondary),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        context.push(
                                            '/inventario/${item.id}/editar',
                                            extra: item);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          color: AppColors.error),
                                      onPressed: () => _confirmarEliminar(
                                          context, ref, item),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => Center(
                  child: Text('No se pudo cargar el desglose',
                      style: AppTextStyles.bodySecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
