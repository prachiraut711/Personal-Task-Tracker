import 'package:flutter/material.dart';

class AppColors {
  // The background is a dark slate blue, not pure dark grey
  static const darkBg = Color(0xFF212832); 
  
  // The primary yellow matches your original choice
  static const primaryYellow = Color(0xFFFED36A);
  
  // The input fields are lighter than the background in this design
  static const inputBg = Color(0xFF455A64); 
  
  // Standard grey for hint text and secondary labels
  static const greyText = Color(0xFF8B8B8B);
  
  // White color for main headlines and titles
  static const whiteText = Colors.white;
}

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBg,

    primaryColor: AppColors.primaryYellow,
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBg,
      hintStyle: const TextStyle(color: Colors.white38),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryYellow,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, 
        ),
        minimumSize: const Size(double.infinity, 55),
      ),
    ),
  );
}