// lib/presentation/screens/logs_actividad/logs_actividad_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/log_actividad.dart';
import '../../../domain/model/logs_actividad_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/logs_actividad_provider.dart';

const _entidades = ['Moto', 'Venta', 'Cliente', 'Financiamiento', 'Vendedor', 'Inventario'];
const _acciones = ['CREATE', 'UPDATE', 'DELETE'];

// Campos técnicos que no aportan nada al mostrarlos en el diff "antes → después".
const _camposIgnorados = {'id'};

class LogsActividadListScreen extends ConsumerStatefulWidget {
  const LogsActividadListScreen({super.key});

  @override
  ConsumerState<LogsActividadListScreen> createState() => _LogsActividadListScreenState();
}

class _LogsActividadListScreenState extends ConsumerState<LogsActividadListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _colorParaAccion(String accion) {
    switch (accion) {
      case 'CREATE':
        return AppColors.success;
      case 'DELETE':
        return AppColors.error;
      case 'UPDATE':
      default:
        return Colors.blue.shade700;
    }
  }

  String _formatearFecha(String fechaIso) {
    final fecha = DateTime.tryParse(fechaIso);
    if (fecha == null) return fechaIso;
    final local = fecha.toLocal();
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${dos(local.day)}/${dos(local.month)}/${local.year} ${dos(local.hour)}:${dos(local.minute)}';
  }

  Future<void> _elegirRangoFechas(LogsActividadState estado) async {
    final rango = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: (estado.fechaDesde != null && estado.fechaHasta != null)
          ? DateTimeRange(start: estado.fechaDesde!, end: estado.fechaHasta!)
          : null,
    );
    if (rango == null) return;
    ref.read(logsActividadProvider.notifier).filtrarPorRangoFechas(rango.start, rango.end);
  }

  Widget _buildFiltroChip(LogsActividadState estado) {
    final activo = estado.fechaDesde != null && estado.fechaHasta != null;
    final label = activo
        ? '${_formatearFecha(estado.fechaDesde!.toIso8601String()).split(' ').first} - '
            '${_formatearFecha(estado.fechaHasta!.toIso8601String()).split(' ').first}'
        : 'Rango de fechas';

    return InkWell(
      onTap: () => _elegirRangoFechas(estado),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: activo ? AppColors.accentLight : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: activo ? AppColors.accent : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.date_range_outlined,
              size: 18,
              color: activo ? AppColors.accent : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: activo ? AppColors.accent : AppColors.textPrimary,
              ),
            ),
            if (activo) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => ref.read(logsActividadProvider.notifier).filtrarPorRangoFechas(null, null),
                child: const Icon(Icons.close, size: 16, color: AppColors.accent),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logsState = ref.watch(logsActividadProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Logs de actividad')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(logsActividadProvider.notifier).loadLogs(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar en los logs...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(logsActividadProvider.notifier).buscar('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) => ref.read(logsActividadProvider.notifier).buscar(value),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: logsState.entidadSeleccionada,
                    decoration: const InputDecoration(labelText: 'Entidad'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                      ..._entidades.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                      ),
                    ],
                    onChanged: (v) => ref.read(logsActividadProvider.notifier).filtrarPorEntidad(v),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: logsState.accionSeleccionada,
                    decoration: const InputDecoration(labelText: 'Acción'),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Todas', overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                      ..._acciones.map(
                        (a) => DropdownMenuItem(
                          value: a,
                          child: Text(a, overflow: TextOverflow.ellipsis, maxLines: 1),
                        ),
                      ),
                    ],
                    onChanged: (v) => ref.read(logsActividadProvider.notifier).filtrarPorAccion(v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Align(alignment: Alignment.centerLeft, child: _buildFiltroChip(logsState)),
            const SizedBox(height: 20),

            Text('${logsState.logs.length} resultados', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 12),

            if (logsState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (logsState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(logsState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (logsState.logs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('No se encontraron logs', style: AppTextStyles.bodySecondary)),
              )
            else
              for (final log in logsState.logs) ...[
                _LogTile(
                  log: log,
                  color: _colorParaAccion(log.accion),
                  fechaFormateada: _formatearFecha(log.fecha),
                ),
                const SizedBox(height: 10),
              ],
          ],
        ),
      ),
    );
  }
}

class _LogTile extends StatelessWidget {
  final LogActividad log;
  final Color color;
  final String fechaFormateada;

  const _LogTile({required this.log, required this.color, required this.fechaFormateada});

  IconData get _icono {
    switch (log.accion) {
      case 'CREATE':
        return Icons.add_circle_outline;
      case 'DELETE':
        return Icons.remove_circle_outline;
      case 'UPDATE':
      default:
        return Icons.edit_outlined;
    }
  }

  String get _titulo {
    switch (log.accion) {
      case 'CREATE':
        return '${log.entidad} creado';
      case 'UPDATE':
        return '${log.entidad} actualizado';
      case 'DELETE':
        return '${log.entidad} eliminado';
      default:
        return log.entidad;
    }
  }

  String get _subtitulo {
    if (log.usuario != null) {
      return '$fechaFormateada · Usuario #${log.usuario}';
    }
    return fechaFormateada;
  }

  @override
  Widget build(BuildContext context) {
    final diferencias = _calcularDiferencias(log.datosAntes, log.datosDespues);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        enabled: diferencias.isNotEmpty,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(_icono, color: color),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _titulo,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                log.accion,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(_subtitulo, style: AppTextStyles.bodySecondary),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: diferencias.isEmpty
            ? const []
            : [
                const Divider(height: 1),
                const SizedBox(height: 10),
                for (final diff in diferencias) _CampoDiffRow(diff: diff),
              ],
      ),
    );
  }
}

/// Un campo cuyo valor cambió (o apareció/desapareció) entre datosAntes y
/// datosDespues, ya formateado para mostrarse en la UI.
class _CampoDiff {
  final String campo;
  final String? antes;
  final String? despues;
  final bool soloAntes;
  final bool soloDespues;

  const _CampoDiff({
    required this.campo,
    this.antes,
    this.despues,
    this.soloAntes = false,
    this.soloDespues = false,
  });
}

List<_CampoDiff> _calcularDiferencias(Map<String, dynamic>? antes, Map<String, dynamic>? despues) {
  final campos = <String>{...?despues?.keys, ...?antes?.keys}..removeAll(_camposIgnorados);

  final diferencias = <_CampoDiff>[];
  for (final campo in campos) {
    final tieneAntes = antes?.containsKey(campo) ?? false;
    final tieneDespues = despues?.containsKey(campo) ?? false;
    final valorAntes = antes?[campo];
    final valorDespues = despues?[campo];

    if (tieneAntes && tieneDespues) {
      if (_valoresIguales(valorAntes, valorDespues)) continue;
      diferencias.add(_CampoDiff(
        campo: campo,
        antes: _formatearValor(valorAntes),
        despues: _formatearValor(valorDespues),
      ));
    } else if (tieneDespues) {
      diferencias.add(_CampoDiff(campo: campo, despues: _formatearValor(valorDespues), soloDespues: true));
    } else if (tieneAntes) {
      diferencias.add(_CampoDiff(campo: campo, antes: _formatearValor(valorAntes), soloAntes: true));
    }
  }
  return diferencias;
}

bool _valoresIguales(dynamic a, dynamic b) {
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final clave in a.keys) {
      if (!b.containsKey(clave) || !_valoresIguales(a[clave], b[clave])) return false;
    }
    return true;
  }
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!_valoresIguales(a[i], b[i])) return false;
    }
    return true;
  }
  return a == b;
}

String _formatearValor(dynamic valor) {
  if (valor == null) return 'Ninguno';
  if (valor is String) return valor.isEmpty ? '(vacío)' : valor;
  if (valor is num || valor is bool) return valor.toString();
  if (valor is List) {
    if (valor.isEmpty) return 'Ninguno';
    if (valor.every((e) => e is String || e is num || e is bool)) {
      return valor.map((e) => e.toString()).join(', ');
    }
    return '${valor.length} elemento${valor.length == 1 ? '' : 's'}';
  }
  if (valor is Map) {
    for (final clave in ['nombre', 'descripcion', 'detalle']) {
      final legible = valor[clave];
      if (legible is String && legible.isNotEmpty) return legible;
    }
    return '${valor.length} campo${valor.length == 1 ? '' : 's'}';
  }
  return valor.toString();
}

class _CampoDiffRow extends StatelessWidget {
  final _CampoDiff diff;

  const _CampoDiffRow({required this.diff});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              diff.campo.replaceAll('_', ' ').toUpperCase(),
              style: AppTextStyles.caption,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: _buildValor()),
        ],
      ),
    );
  }

  Widget _buildValor() {
    if (diff.soloAntes) {
      return Text(
        diff.antes ?? '',
        style: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
          decoration: TextDecoration.lineThrough,
        ),
      );
    }
    if (diff.soloDespues) {
      return Text(diff.despues ?? '', style: AppTextStyles.body);
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          diff.antes ?? '',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 14, color: AppColors.textSecondary),
        ),
        Text(
          diff.despues ?? '',
          style: AppTextStyles.body.copyWith(color: AppColors.accent, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
