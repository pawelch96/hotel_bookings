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
  static const defaultHorizontalPadding = EdgeInsets.symmetric(horizontal: 16);
  static const defaultHorizontalXSmallPadding = EdgeInsets.symmetric(horizontal: 4);
  static const defaultRadius = BorderRadius.all(Radius.circular(5));
  static const defaultRadiusSmall = BorderRadius.all(Radius.circular(2));
  static const defaultImageRadius = BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(5),
  );

  static const spaceXSmall = 4.0;
  static const spaceSmall = 8.0;
  static const spaceMedium = 12.0;
  static const spaceRegular = 16.0;

  static const iconSmall = 20.0;
  static const iconXSmall = 14.0;

  static const BoxShadow cardShadowPrimary = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 8),
    blurRadius: 24,
    spreadRadius: 0,
  );

  static const BoxShadow cardShadowSecondary = BoxShadow(
    color: Color(0x14000000),
    offset: Offset.zero,
    blurRadius: 24,
    spreadRadius: 0,
  );

  static const favoriteIconShadow = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 4),
    blurRadius: 10,
  );

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

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.backgroundBrand,
      brightness: Brightness.light,
      primary: AppColors.backgroundBrand,
      secondary: AppColors.interactionPrimary,
      surface: AppColors.backgroundPrimary,
      onSurface: AppColors.contentPrimary,
      onPrimary: AppColors.contentInverse,
      onSecondary: AppColors.contentInverse,
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
        shape: RoundedRectangleBorder(borderRadius: defaultRadius),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
