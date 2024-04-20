import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.baseWhite,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: AppColors.dark)),
      ),
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
            side: const BorderSide(width: 1.5),
            textStyle: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: AppColors.dark)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: AppColors.lightGrey,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: Color.fromARGB(255, 214, 213, 211)),
            borderRadius: BorderRadius.circular(Measures.basicRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: AppColors.dark),
            borderRadius: BorderRadius.circular(Measures.basicRadius)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: AppColors.red),
            borderRadius: BorderRadius.circular(Measures.basicRadius)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: AppColors.red),
            borderRadius: BorderRadius.circular(Measures.basicRadius)),
        hintStyle: GoogleFonts.urbanist(
            fontSize: 14, color: AppColors.dark.withOpacity(0.5)),
      ),
      textTheme: TextTheme(
        labelLarge: GoogleFonts.urbanist(
            fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark),
        titleLarge: GoogleFonts.urbanist(
            fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.dark),
        titleMedium: GoogleFonts.urbanist(
            fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.dark),
        titleSmall: GoogleFonts.urbanist(
            fontSize: 20,
            color: AppColors.baseWhite,
            fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.urbanist(fontSize: 14, color: AppColors.dark),
      ));
}
