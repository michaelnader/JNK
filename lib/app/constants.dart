import 'package:flutter/material.dart';

/// Centralized design tokens for the JNK Privilege Club aesthetic.
///
/// Premium "Chic Dark Mode": deep obsidian canvas, muted platinum/gold accents,
/// midnight blue for cooler surfaces. All glass widgets and themed components
/// resolve their colors from here.
abstract final class AppColors {
  // Base canvas — deep obsidian
  static const Color obsidianDeep = Color(0xFF0A0A0A);
  static const Color obsidian = Color(0xFF121212);
  static const Color charcoal = Color(0xFF161821);
  static const Color graphite = Color(0xFF1F2230);

  // Cool accent — deep midnight blue
  static const Color midnight = Color(0xFF0F172A);
  static const Color midnightSoft = Color(0xFF1E293B);

  // Warm accent — champagne gold
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldSoft = Color(0xFFB89028);

  // Cool light accent — platinum
  static const Color platinum = Color(0xFFEFEFEF);
  static const Color platinumDim = Color(0xFFB8BAC2);

  // Text
  static const Color textPrimary = Color(0xFFF4F5F7);
  static const Color textSecondary = Color(0xFFA5A8B5);
  static const Color textTertiary = Color(0xFF6B6E7D);
  static const Color textMuted = Color(0xFF4A4D5A);

  // Glass surface tokens — keep in sync with [AppGlass]
  static const Color glassFill = Color(0x14FFFFFF); // 0.08 alpha white
  static const Color glassBorder = Color(0x26FFFFFF); // 0.15 alpha white
  static const Color glassHighlight = Color(0x33FFFFFF); // 0.20 alpha white

  // Semantic
  static const Color success = Color(0xFF6FCF97);
  static const Color warning = Color(0xFFF2C94C);
  static const Color danger = Color(0xFFEB5757);

  // Tier badges
  static const Color tierSilver = Color(0xFFB8BAC2);
  static const Color tierGold = Color(0xFFD4AF37);
  static const Color tierPlatinum = Color(0xFFE5E4E2);
  static const Color tierObsidian = Color(0xFF1A1A1A);
}

/// Glass tuning constants — single source of truth for the glassmorphism look.
abstract final class AppGlass {
  static const double blurSigma = 10.0;
  static const double fillOpacity = 0.08;
  static const double borderOpacity = 0.15;
  static const double borderWidth = 1.0;
}

/// Spacing scale (multiples of 4).
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xl2 = 24;
  static const double xl3 = 32;
  static const double xl4 = 40;
  static const double xl5 = 48;
  static const double xl6 = 64;
}

/// Corner radii.
abstract final class AppRadii {
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xl2 = 28;
  static const double pill = 999;
}

/// Animation durations.
abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 520);
  static const Duration ambient = Duration(seconds: 12);
}
