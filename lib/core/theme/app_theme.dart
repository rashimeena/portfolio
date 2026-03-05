import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkNeon() {
    const neonBlue = Color(0xFF00E5FF);
    const deepBlue = Color(0xFF0A0F1F);
    const cardBlue = Color(0xFF11182F);

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      scaffoldBackgroundColor: deepBlue,

      colorScheme: const ColorScheme.dark(
        primary: neonBlue,
        secondary: Color(0xFF64FFDA),
       // background: deepBlue,
        surface: deepBlue,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE0E0E0),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Color(0xFFB0BEC5),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF90A4AE),
        ),
      ),

      // ✅ MATERIAL 3 CARD THEME
      cardTheme: CardThemeData(
        color: cardBlue,
        elevation: 8,
        shadowColor: neonBlue.withValues(alpha: .25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: deepBlue,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
