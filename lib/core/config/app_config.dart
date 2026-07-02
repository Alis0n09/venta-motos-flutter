// lib/core/config/app_config.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Cambiar a true cuando queramos probar con el local
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

  static const String appName = 'Venta Motos App';
  static const double taxRate = 0.15; // IVA Ecuador 15%
}