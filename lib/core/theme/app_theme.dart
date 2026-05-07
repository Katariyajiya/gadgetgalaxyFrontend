import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      // Default font families (assuming you add them via google_fonts or assets)
      // fontFamily: 'Outfit',

      // AppBar Theme styling
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text1,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.text2),
        titleTextStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans', // Fallback to default if not added
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.text1,
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.text1, fontWeight: FontWeight.w800),
        displayMedium: TextStyle(color: AppColors.text1, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(color: AppColors.text1, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.text1, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: AppColors.text2, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: AppColors.text3, fontWeight: FontWeight.w400),
      ),

      // Elevated Button Theme (Mapped to .btn-primary in CSS)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
          ),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.border1,
        thickness: 1,
        space: 1,
      ),

      // Input Decoration (Search bars, form inputs)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: AppColors.border1, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: AppColors.border1, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: AppColors.text3, fontSize: 13),
      ),
    );
  }
}