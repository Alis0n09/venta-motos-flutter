// lib/data/local/favoritos_storage.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoritosStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// [userId] identifica de quién son los favoritos, para que cada cuenta
  /// tenga su propio cajón y nunca se mezclen entre usuarios del mismo equipo.
  String _keyFor(int userId) => 'venta_motos_app:favoritos:$userId';

  Future<Set<int>> getFavoritos(int userId) async {
    final raw = await _storage.read(key: _keyFor(userId));
    if (raw == null || raw.isEmpty) return {};
    return raw.split(',').map(int.parse).toSet();
  }

  Future<void> saveFavoritos(int userId, Set<int> ids) async {
    await _storage.write(key: _keyFor(userId), value: ids.join(','));
  }
}

final favoritosStorageProvider = Provider<FavoritosStorage>((_) => FavoritosStorage());