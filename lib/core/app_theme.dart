import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final base = ThemeData(brightness: Brightness.dark);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.arimoTextTheme(
        base.textTheme,
      ).apply(bodyColor: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
