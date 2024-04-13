import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hearu/config/colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.baseWhite,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueMain,
            foregroundColor: AppColors.white,
            elevation: 0.0,
            textStyle: GoogleFonts.urbanist(
                fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.dark,
            elevation: 0.0,
            side: const BorderSide(width: 1.5)),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.urbanist(
            fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.dark),
        bodyLarge: GoogleFonts.urbanist(fontSize: 14, color: AppColors.dark),
      ));
}
