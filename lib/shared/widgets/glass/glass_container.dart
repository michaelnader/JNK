import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/constants.dart';

/// Low-level building block for every glassmorphism surface in the app.
///
/// Composes the canonical recipe from the design spec:
///   ClipRRect -> BackdropFilter(blur sigmaX/Y) -> DecoratedBox(fill + border + gradient)
///
/// Higher-level widgets ([GlassCard], [GlassButton], [GlassModal]) wrap this
/// and pre-apply sensible defaults; reach for [GlassContainer] directly only
/// when you need to break those defaults (e.g. a custom shaped surface).
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    required this.child,
    super.key,
    this.blurSigma = AppGlass.blurSigma,
    this.fillOpacity = AppGlass.fillOpacity,
    this.borderOpacity = AppGlass.borderOpacity,
    this.borderWidth = AppGlass.borderWidth,
    this.borderRadius,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.overlayGradient,
    this.borderColor,
    this.shadows,
    this.enableInnerHighlight = true,
    this.tintColor = Colors.white,
  });

  final Widget child;
  final double blurSigma;
  final double fillOpacity;
  final double borderOpacity;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;

  /// Optional gradient painted *over* the fill (e.g. a subtle top-to-bottom
  /// highlight). Defaults to a faint top highlight when null + [enableInnerHighlight].
  final Gradient? overlayGradient;

  /// Override the border color. Defaults to translucent white per design spec.
  final Color? borderColor;

  /// Outer shadows. When null a soft elevation shadow is used.
  final List<BoxShadow>? shadows;

  /// When true (and [overlayGradient] is null) renders a faint top-to-bottom
  /// highlight that reads as "lit from above".
  final bool enableInnerHighlight;

  /// The hue applied to the fill + border. Defaults to white; use a tinted
  /// color (e.g. gold) for emphasis surfaces.
  final Color tintColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppRadii.xl);

    final resolvedShadows = shadows ??
        const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 32,
            offset: Offset(0, 18),
          ),
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ];

    final fill = tintColor.withValues(alpha: fillOpacity);
    final border = (borderColor ?? tintColor)
        .withValues(alpha: borderOpacity);

    final gradient = overlayGradient ??
        (enableInnerHighlight
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.06),
                  Colors.white.withValues(alpha: 0.0),
                ],
              )
            : null);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: resolvedShadows,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: radius,
              border: Border.all(color: border, width: borderWidth),
              gradient: gradient,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
