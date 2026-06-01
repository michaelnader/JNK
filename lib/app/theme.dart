import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

/// Light "Off Duty" theme — Warm Sand scene + Plus Jakarta Sans throughout.
ThemeData buildGnkTheme() {
  final base = ThemeData.light(useMaterial3: true);
  final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
    bodyColor: AppColors.textDark,
    displayColor: AppColors.textDark,
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.warmSand,
    colorScheme: const ColorScheme.light(
      primary: AppColors.gold,
      onPrimary: AppColors.textDark,
      secondary: AppColors.charcoal,
      onSecondary: AppColors.textWhite,
      surface: AppColors.softCream,
      onSurface: AppColors.textDark,
      error: AppColors.gold,
      onError: AppColors.textDark,
    ),
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    iconTheme: const IconThemeData(color: AppColors.textDark, size: 18),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
  );
}
