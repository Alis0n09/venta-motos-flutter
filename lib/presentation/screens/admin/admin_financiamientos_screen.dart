// lib/presentation/screens/admin/admin_financiamientos_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/financiamiento_admin_provider.dart';

class AdminFinanciamientosScreen extends ConsumerStatefulWidget {
  const AdminFinanciamientosScreen({super.key});

  @override
  ConsumerState<AdminFinanciamientosScreen> createState() => _AdminFinanciamientosScreenState();
}

class _AdminFinanciamientosScreenState extends ConsumerState<AdminFinanciamientosScreen> {
  String? _estadoFiltro;

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'pagado':
        return AppColors.success;
      case 'cancelado':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final financiamientosAsync = ref.watch(financiamientosAdminProvider(_estadoFiltro));

    return Scaffold(
      appBar: AppBar(title: const Text('Financiamientos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FiltroChip(
                    label: 'Todos',
                    seleccionado: _estadoFiltro == null,
                    onTap: () => setState(() => _estadoFiltro = null),
                  ),
                  const SizedBox(width: 8),
                  _FiltroChip(
                    label: 'Activos',
                    seleccionado: _estadoFiltro == 'activo',
                    onTap: () => setState(() => _estadoFiltro = 'activo'),
                  ),
                  const SizedBox(width: 8),
                  _FiltroChip(
                    label: 'Pagados',
                    seleccionado: _estadoFiltro == 'pagado',
                    onTap: () => setState(() => _estadoFiltro = 'pagado'),
                  ),
                  const SizedBox(width: 8),
                  _FiltroChip(
                    label: 'Cancelados',
                    seleccionado: _estadoFiltro == 'cancelado',
                    onTap: () => setState(() => _estadoFiltro = 'cancelado'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(financiamientosAdminProvider(_estadoFiltro).future),
              child: financiamientosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ListView(
                  children: [
                    const SizedBox(height: 80),
                    Center(child: Text('No se pudieron cargar los financiamientos', style: AppTextStyles.bodySecondary)),
                  ],
                ),
                data: (financiamientos) => financiamientos.isEmpty
                    ? ListView(
                        children: const [
                          SizedBox(height: 80),
                          Center(child: Text('No hay financiamientos registrados', style: AppTextStyles.bodySecondary)),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: financiamientos.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final f = financiamientos[index];
                          return Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              onTap: () => context.push('/admin/financiamientos/detalle', extra: f.venta),
                              title: Text(f.clienteNombre ?? 'Venta #${f.venta}'),
                              subtitle: Text(
                                '${f.motoDetalle.isNotEmpty ? f.motoDetalle.join(', ') : 'Sin detalle'}\n'
                                'Desde ${DateFormat('dd/MM/yyyy').format(f.fechaInicio)} · ${f.plazoMeses} meses',
                              ),
                              isThreeLine: true,
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('\$${f.montoFinanciado.toStringAsFixed(0)}', style: AppTextStyles.price),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: _colorEstado(f.estado).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      f.estado,
                                      style: TextStyle(
                                        color: _colorEstado(f.estado),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FiltroChip extends StatelessWidget {
  final String label;
  final bool seleccionado;
  final VoidCallback onTap;

  const _FiltroChip({required this.label, required this.seleccionado, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: seleccionado,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.accentLight,
      labelStyle: TextStyle(
        color: seleccionado ? AppColors.accent : AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: AppColors.surface,
      side: const BorderSide(color: AppColors.border),
    );
  }
}