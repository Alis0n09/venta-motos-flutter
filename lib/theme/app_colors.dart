// lib/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Color principal de marca (botones oscuros, textos fuertes, header)
  static const Color primary = Color(0xFF1A1A1A);
  static const Color primaryDark = Color(0xFF000000);

  // Acento (precios, badges, chips seleccionados, elementos destacados)
  static const Color accent = Color(0xFFFF2D78);
  static const Color accentLight = Color(0xFFFFE1EC);

  // Fondos
  static const Color background = Color(0xFFF5F5F3);
  static const Color surface = Color(0xFFFFFFFF);

  // Texto
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8A8A8E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFFFFFFFF);

  // Estados (SnackBars, validaciones)
  static const Color success = Color(0xFF2A9D5C);
  static const Color error = Color(0xFFD62828);
  static const Color warning = Color(0xFFE9A23B);

  // Bordes / divisores
  static const Color border = Color(0xFFE5E5E3);
}