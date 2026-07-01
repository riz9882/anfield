import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFC8102E);
  static const accent = Color(0xFF9B0F24);
  static const primaryLight = Color(0xFFE8354F);
  static const white = Color(0xFFFFFFFF);
  static const offWhite = Color(0xFFF5F5F5);
  static const darkBg = Color(0xFF1A0508);
  static const cardBg = Color(0xFF2A0C12);
  static const surfaceLight = Color(0xFFFAFAFA);
  static const textMuted = Color(0xFF9E9092);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.surfaceLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.white,
        surface: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(height: 1.6),
      ),
    );
  }
}
