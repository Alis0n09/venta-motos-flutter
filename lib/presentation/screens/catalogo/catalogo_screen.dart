// lib/presentation/screens/catalogo/catalogo_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../providers/catalog_provider.dart';
import '../../widgets/moto_card.dart';

class CatalogoScreen extends ConsumerStatefulWidget {
  const CatalogoScreen({super.key});

  @override
  ConsumerState<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends ConsumerState<CatalogoScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogState = ref.watch(catalogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de motos')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(catalogProvider.notifier).loadMotos(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscá marca, modelo...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(catalogProvider.notifier).buscar('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) => ref.read(catalogProvider.notifier).buscar(value),
            ),
            const SizedBox(height: 20),

            Text(
              '${catalogState.motos.length} resultados',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 12),

            if (catalogState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (catalogState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text(catalogState.error!, style: AppTextStyles.bodySecondary)),
              )
            else if (catalogState.motos.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('No se encontraron motos', style: AppTextStyles.bodySecondary)),
              )
            else
              for (final moto in catalogState.motos) ...[
                MotoCard(
                  moto: moto,
                  onTap: () => context.push('/moto/${moto.id}'),
                ),
                const SizedBox(height: 10),
              ],
          ],
        ),
      ),
    );
  }
}