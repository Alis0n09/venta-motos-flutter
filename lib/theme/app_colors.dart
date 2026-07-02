// lib/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Color principal de marca (botones, links, elementos activos)
  static const Color primary = Color(0xFFE63946);
  static const Color primaryDark = Color(0xFFB22C37);

  // Color secundario (acentos, iconos secundarios)
  static const Color secondary = Color(0xFF2B2D42);

  // Fondos
  static const Color background = Color(0xFFF7F7F9);
  static const Color surface = Color(0xFFFFFFFF);

  // Texto
  static const Color textPrimary = Color(0xFF1B1B1F);
  static const Color textSecondary = Color(0xFF6C6C74);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Estados (para SnackBars, validaciones, badges de rol)
  static const Color success = Color(0xFF2A9D5C);
  static const Color error = Color(0xFFD62828);
  static const Color warning = Color(0xFFE9A23B);

  // Bordes / divisores
  static const Color border = Color(0xFFE0E0E4);
}