import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.coral,
      onSecondary: AppColors.background,
      error: AppColors.coral,
      onError: AppColors.background,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    final textTheme = const TextTheme(
      headlineMedium: AppTextStyles.headline,
      titleMedium: AppTextStyles.title,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
      labelLarge: AppTextStyles.button,
      labelSmall: AppTextStyles.label,
    ).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

        return ThemeData(
      fontFamily: 'Inter',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
    );
  }
}