// lib/core/config/app_config.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Cambia esto a `true` cuando quieras probar contra tu Django local
  static const bool usarLocal = false;

  static String get envFileName => usarLocal ? '.env.dev' : '.env';

  static String get apiBaseUrl {
    final url = dotenv.env['API_BASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception(
        'API_BASE_URL no está definida en $envFileName. Revisa que el archivo exista y tenga la variable.',
      );
    }
    return url;
  }
}