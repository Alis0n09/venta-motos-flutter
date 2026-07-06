// lib/presentation/screens/logs_actividad/logs_actividad_list_screen.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/log_actividad.dart';
import '../../../domain/model/logs_actividad_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/logs_actividad_provider.dart';

const _entidades = ['Moto', 'Venta', 'Cliente', 'Financiamiento', 'Vendedor', 'Inventario'];
const _acciones = ['CREATE', 'UPDATE', 'DELETE'];
const _jsonEncoder = JsonEncoder.withIndent('  ');

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

  @override
  Widget build(BuildContext context) {
    final logsState = ref.watch(logsActividadProvider);

    return Scaffold(
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

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _elegirRangoFechas(logsState),
                    icon: const Icon(Icons.date_range_outlined),
                    label: Text(
                      (logsState.fechaDesde != null && logsState.fechaHasta != null)
                          ? '${_formatearFecha(logsState.fechaDesde!.toIso8601String()).split(' ').first} - '
                              '${_formatearFecha(logsState.fechaHasta!.toIso8601String()).split(' ').first}'
                          : 'Rango de fechas',
                    ),
                  ),
                ),
                if (logsState.fechaDesde != null || logsState.fechaHasta != null)
                  IconButton(
                    tooltip: 'Quitar filtro de fechas',
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        ref.read(logsActividadProvider.notifier).filtrarPorRangoFechas(null, null),
                  ),
              ],
            ),
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

  @override
  Widget build(BuildContext context) {
    final tieneDatos = log.datosAntes != null || log.datosDespues != null;

    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        enabled: tieneDatos,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                log.accion,
                style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(log.entidad, style: AppTextStyles.body)),
          ],
        ),
        subtitle: Text(fechaFormateada, style: AppTextStyles.bodySecondary),
        children: tieneDatos
            ? [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (log.datosAntes != null) ...[
                        const Text('DATOS ANTES', style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        _JsonBlock(datos: log.datosAntes!),
                        const SizedBox(height: 12),
                      ],
                      if (log.datosDespues != null) ...[
                        const Text('DATOS DESPUÉS', style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        _JsonBlock(datos: log.datosDespues!),
                      ],
                    ],
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}

class _JsonBlock extends StatelessWidget {
  final Map<String, dynamic> datos;

  const _JsonBlock({required this.datos});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        _jsonEncoder.convert(datos),
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}
