import 'package:flutter/material.dart';

/// G'nK Restaurants — Off Duty v8 design tokens.
///
/// Warm cream scenes with denim & charcoal cards. First light-scene variant.
/// Soft Cream + Warm Sand backdrops; True Black/Charcoal dark cards;
/// Washed/Deep Denim as the universal accent ("gold" naming kept from v5
/// for continuity, but now denim-toned); Soft Chrome reserved for gradient
/// material surfaces.
abstract final class AppColors {
  // Scene
  static const Color warmSand = Color(0xFFE6DED2);
  static const Color softCream = Color(0xFFF5F1EA);

  // Dark surfaces
  static const Color trueBlack = Color(0xFF0E0E0E);
  static const Color charcoal = Color(0xFF2B2B2B);

  // Denim accent (kept the `gold*` semantic names from v5)
  static const Color gold = Color(0xFF6F8597); // Washed Denim — universal accent
  static const Color goldLight = Color(0xFFA1B5C2); // lifted denim
  static const Color goldDeep = Color(0xFF2F3E4A); // Deep Denim
  static const Color goldSoft = Color(0x266F8597); // 15% denim wash

  // Material accent
  static const Color chrome = Color(0xFFC9C9C7);

  // Text
  static const Color textDark = Color(0xFF0E0E0E);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textMuteLight = Color(0x8C0E0E0E); // 0.55
  static const Color textMuteDark = Color(0x9EFFFFFF); // 0.62
  static const Color textFaintLight = Color(0x590E0E0E); // 0.35
  static const Color textFaintDark = Color(0x61FFFFFF); // 0.38

  // Dividers
  static const Color divLight = Color(0x1A0E0E0E); // 0.10
  static const Color divDark = Color(0x1AFFFFFF); // 0.10
}

/// Photo treatment — monochrome with a barely-there Deep Denim tint so
/// restaurant photography reads as one cool, coherent surface against the
/// warm cream context.
abstract final class AppPhoto {
  /// ColorFilter matrix equivalent to `grayscale(100%) contrast(1.06) brightness(0.94)`.
  ///
  /// Apply in the order: brightness → contrast → grayscale (multiplicative).
  /// We collapse to a single matrix below.
  static const ColorFilter monoFilter = ColorFilter.matrix(<double>[
    // grayscale * contrast 1.06 * brightness 0.94 ≈ 0.2126 * 1.06 * 0.94 ≈ 0.2119
    0.2119, 0.7128, 0.0719, 0, -7.65,
    0.2119, 0.7128, 0.0719, 0, -7.65,
    0.2119, 0.7128, 0.0719, 0, -7.65,
    0, 0, 0, 1, 0,
  ]);

  /// Deep Denim tint blended in `color` mode over the monochrome photo.
  static const Color monoTint = Color(0x2E2F3E4A); // rgba(47,62,74,0.18)
}

/// Scene gradient: Soft Cream → Warm Sand vertically.
const Gradient appSceneGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[AppColors.softCream, AppColors.warmSand],
);

/// Spacing scale (multiples of 4) — kept compatible with v1 naming.
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

/// Corner radii — 30 for cards, pill (9999) for CTAs and chips.
abstract final class AppRadii {
  static const double chip = 9999;
  static const double pill = 9999;
  static const double card = 30;
  static const double cardSmall = 22;
  static const double cardTiny = 14;
  static const double field = 16;
}

abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 520);
}
