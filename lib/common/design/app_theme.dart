import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.light).copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme(Brightness.light),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      dividerColor: AppColors.divider,
    );
  }

  static ThemeData get darkTheme {
    const Color darkBackground = Color(0xFF0B1220);
    const Color darkSurface = Color(0xFF111827);
    const Color darkTextPrimary = Color(0xFFF1F5F9);

    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.dark).copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: darkSurface,
          error: AppColors.error,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: darkBackground,
      textTheme: _textTheme(Brightness.dark),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkTextPrimary,
        elevation: 0,
      ),
      dividerColor: const Color(0xFF334155),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final Color textColor = brightness == Brightness.dark
        ? const Color(0xFFF1F5F9)
        : AppColors.textPrimary;

    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: textColor),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: textColor),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: textColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: textColor),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: textColor),
    );
  }
}
