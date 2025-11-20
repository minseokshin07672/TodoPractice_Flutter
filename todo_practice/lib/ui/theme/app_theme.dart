import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.greyBackground,
    primaryColor: AppColors.primary,
    fontFamily: 'Pretendard',

    textTheme: TextTheme(
      headlineLarge: AppTypography.h1,
      headlineMedium: AppTypography.h2,
      bodyLarge: AppTypography.body,
      bodyMedium: AppTypography.small,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
  );
}
