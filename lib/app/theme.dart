import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

/// Builds the dark, premium ThemeData for JNK Privilege Club.
///
/// Typography: Inter for UI, Cormorant Garamond for hero/display headings.
/// The colour scheme is anchored to [AppColors.obsidian] and accented with
/// muted gold + midnight blue. Component themes are kept intentionally minimal
/// so the bespoke Glass widgets remain the dominant visual language.
class AppTheme {
  const AppTheme._();

  static SystemUiOverlayStyle get systemOverlay => const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.obsidianDeep,
        systemNavigationBarIconBrightness: Brightness.light,
      );

  static ThemeData build() {
    final base = ThemeData.dark(useMaterial3: true);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.gold,
      brightness: Brightness.dark,
      surface: AppColors.obsidian,
      onSurface: AppColors.textPrimary,
      primary: AppColors.gold,
      onPrimary: AppColors.obsidianDeep,
      secondary: AppColors.midnight,
      onSecondary: AppColors.platinum,
      error: AppColors.danger,
    );

    final textTheme = _buildTextTheme(base.textTheme);

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.obsidianDeep,
      canvasColor: AppColors.obsidianDeep,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 22,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.glassBorder,
        thickness: 0.6,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: systemOverlay,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      splashFactory: InkRipple.splashFactory,
      splashColor: AppColors.gold.withValues(alpha: 0.08),
      highlightColor: Colors.transparent,
      hoverColor: AppColors.glassHighlight,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    final display = GoogleFonts.cormorantGaramondTextTheme(base);
    final body = GoogleFonts.interTextTheme(base);

    TextStyle? d(TextStyle? s) =>
        s?.copyWith(color: AppColors.textPrimary, height: 1.1);
    TextStyle? b(TextStyle? s, {Color? color, double height = 1.45}) =>
        s?.copyWith(color: color ?? AppColors.textPrimary, height: height);

    return base.copyWith(
      displayLarge: d(display.displayLarge)?.copyWith(letterSpacing: -1.0),
      displayMedium: d(display.displayMedium)?.copyWith(letterSpacing: -0.6),
      displaySmall: d(display.displaySmall)?.copyWith(letterSpacing: -0.4),
      headlineLarge: d(display.headlineLarge)?.copyWith(fontWeight: FontWeight.w500),
      headlineMedium: d(display.headlineMedium)?.copyWith(fontWeight: FontWeight.w500),
      headlineSmall: b(body.headlineSmall)?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      titleLarge: b(body.titleLarge)?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      titleMedium: b(body.titleMedium)?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: b(body.titleSmall, color: AppColors.textSecondary),
      bodyLarge: b(body.bodyLarge),
      bodyMedium: b(body.bodyMedium, color: AppColors.textSecondary),
      bodySmall: b(body.bodySmall, color: AppColors.textTertiary),
      labelLarge: b(body.labelLarge)?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
      labelMedium: b(body.labelMedium, color: AppColors.textSecondary)
          ?.copyWith(letterSpacing: 0.4),
      labelSmall: b(body.labelSmall, color: AppColors.textTertiary)
          ?.copyWith(letterSpacing: 1.2),
    );
  }
}
