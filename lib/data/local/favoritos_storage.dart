// lib/data/local/favoritos_storage.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoritosStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const _key = 'venta_motos_app:favoritos';

  Future<Set<int>> getFavoritos() async {
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.isEmpty) return {};
    return raw.split(',').map(int.parse).toSet();
  }

  Future<void> saveFavoritos(Set<int> ids) async {
    await _storage.write(key: _key, value: ids.join(','));
  }
}

final favoritosStorageProvider = Provider<FavoritosStorage>((_) => FavoritosStorage());