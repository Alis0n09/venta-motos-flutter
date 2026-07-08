// lib/presentation/screens/admin/admin_historial_clientes_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/historial_cliente_provider.dart';

class AdminHistorialClientesScreen extends ConsumerStatefulWidget {
  const AdminHistorialClientesScreen({super.key});

  @override
  ConsumerState<AdminHistorialClientesScreen> createState() => _AdminHistorialClientesScreenState();
}

class _AdminHistorialClientesScreenState extends ConsumerState<AdminHistorialClientesScreen> {
  final _busquedaController = TextEditingController();
  String? _busqueda;

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  void _aplicarBusqueda() {
    final texto = _busquedaController.text.trim();
    setState(() => _busqueda = texto.isEmpty ? null : texto);
  }

  IconData _iconoEvento(String tipoEvento) {
    switch (tipoEvento) {
      case 'mantenimiento':
        return Icons.build_outlined;
      case 'garantia':
        return Icons.verified_outlined;
      case 'resena':
        return Icons.star_outline;
      case 'financiamiento':
        return Icons.credit_score_outlined;
      default:
        return Icons.history;
    }
  }

  @override
  Widget build(BuildContext context) {
    final historialAsync = ref.watch(historialClientesAdminProvider(_busqueda));

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de clientes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _busquedaController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar por cédula, nombre o apellido',
                      isDense: true,
                      prefixIcon: Icon(Icons.search, size: 20),
                    ),
                    onSubmitted: (_) => _aplicarBusqueda(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _aplicarBusqueda,
                ),
                if (_busqueda != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _busquedaController.clear();
                      setState(() => _busqueda = null);
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(historialClientesAdminProvider(_busqueda).future),
              child: historialAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => ListView(
                  children: [
                    const SizedBox(height: 80),
                    Center(child: Text('No se pudo cargar el historial', style: AppTextStyles.bodySecondary)),
                  ],
                ),
                data: (historial) => historial.isEmpty
                    ? ListView(
                        children: [
                          const SizedBox(height: 80),
                          Center(
                            child: Text(
                              _busqueda != null ? 'Sin resultados para "$_busqueda"' : 'No hay eventos registrados',
                              style: AppTextStyles.bodySecondary,
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: historial.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final h = historial[index];
                          return Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.accentLight,
                                child: Icon(_iconoEvento(h.tipoEvento), color: AppColors.accent, size: 20),
                              ),
                              title: Text(h.clienteNombre ?? 'Cliente #${h.cliente}'),
                              subtitle: Text(
                                '${h.tipoEvento}'
                                '${h.clienteCedula != null ? ' · CI ${h.clienteCedula}' : ''}\n'
                                '${DateFormat('dd/MM/yyyy HH:mm').format(h.fecha)}',
                              ),
                              isThreeLine: true,
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