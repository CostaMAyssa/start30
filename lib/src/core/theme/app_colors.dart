import 'package:flutter/material.dart';

/// Cores do aplicativo
class AppColors {
  /// Cor primária
  static const Color primary = Color(0xFF0A0A0A);

  /// Cor secundária
  static const Color secondary = Color(0xFFFF5F00);

  /// Cor de fundo
  static const Color background = Color(0xFF111111);

  /// Cor de texto primária
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Cor de texto secundária
  static const Color textSecondary = Color(0xFFB3B3B3);

  /// Cor de borda
  static const Color border = Color(0xFF2A2A2A);

  /// Cor de erro
  static const Color error = Color(0xFFFF3B30);

  /// Cor de sucesso
  static const Color success = Color(0xFF34C759);

  /// Cor de aviso
  static const Color warning = Color(0xFFFFCC00);

  /// Cor de informação
  static const Color info = Color(0xFF007AFF);

  // Cores de fundo
  static const Color cardBackground = Colors.white;
  static const Color darkBackground = Color(0xFF0A2540); // Inspirado no Stripe
  
  // Cores de texto
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Colors.white;
  
  // Cores de gradiente (inspiradas no Stripe)
  static const List<Color> gradientPrimary = [
    Color(0xFF000000),
    Color(0xFF333333),
  ];
  
  static const List<Color> gradientSecondary = [
    Color(0xFFFF914D),
    Color(0xFFFF7A1F),
  ];
  
  // Cores para elementos de UI
  static const Color divider = Color(0xFFE5E7EB);
  static const Color inputBackground = Color(0xFFF3F4F6);
  static const Color disabled = Color(0xFFE5E7EB);
  
  // Cores para botões
  static const Color buttonPrimary = Color(0xFF000000);
  static const Color buttonSecondary = Color(0xFFFF914D);
  static const Color buttonDisabled = Color(0xFFE5E7EB);
} 