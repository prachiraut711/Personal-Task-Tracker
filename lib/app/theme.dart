import 'package:flutter/material.dart';

class AppColors {
  static const darkBg = Color(0xFF1E1E1E);
  static const primaryYellow = Color(0xFFFED36A);
  static const inputBg = Color(0xFF262626);
  static const greyText = Color(0xFF8B8B8B);
}

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    primaryColor: AppColors.primaryYellow,
    colorScheme: const ColorScheme.dark(primary: AppColors.primaryYellow),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBg,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryYellow,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 55),
      ),
    ),
  );
}