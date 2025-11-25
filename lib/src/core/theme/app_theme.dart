import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  const AppColors._();

  static const contentPrimary = Color(0xFF222222);
  static const contentSecondary = Color(0xFF595959);
  static const contentInverse = Color(0xFFFFFFFF);
  static const contentAccent = Color(0xFF85BC39);

  static const borderPrimary = Color(0xFFC8C8C8);
  static const borderSecondary = Color(0xFFE9E9E9);

  static const backgroundPrimary = Color(0xFFFFFFFF);
  static const backgroundBrand = Color(0xFF002873);

  static const interactionPrimary = Color(0xFFFF8F16);
}

class AppTheme {
  const AppTheme._();

  static const defaultPadding = EdgeInsets.all(16);
  static const defaultRadius = BorderRadius.all(Radius.circular(5));

  static ThemeData get light {
    final textTheme = TextTheme(
      headlineSmall: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 22 / 16,
        color: AppColors.contentInverse,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 22 / 18,
        color: AppColors.contentPrimary,
      ),
      titleLarge: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
        color: AppColors.contentPrimary,
      ),
      titleMedium: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 22 / 16,
        color: AppColors.contentPrimary,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: AppColors.contentSecondary,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 20 / 14,
        color: AppColors.contentInverse,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        color: AppColors.contentSecondary,
      ),
      labelSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 16 / 12,
        color: AppColors.contentInverse,
      ),
    );

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.backgroundBrand,
          brightness: Brightness.light,
          primary: AppColors.backgroundBrand,
          secondary: AppColors.interactionPrimary,
          surface: AppColors.backgroundPrimary,
          onSurface: AppColors.contentPrimary,
        ).copyWith(
          onPrimary: AppColors.contentInverse,
          onSecondary: AppColors.contentInverse,
          error: Colors.red,
          onError: AppColors.contentInverse,
          outline: AppColors.borderPrimary,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundBrand,
        foregroundColor: AppColors.contentInverse,
        elevation: 0,
      ),
      textTheme: textTheme,
      dividerColor: AppColors.borderSecondary,
      cardTheme: const CardThemeData(
        color: AppColors.backgroundPrimary,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: defaultRadius,
          side: BorderSide(color: AppColors.borderSecondary),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
