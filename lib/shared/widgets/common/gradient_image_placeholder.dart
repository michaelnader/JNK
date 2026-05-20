import 'package:flutter/material.dart';

import '../../../app/constants.dart';

/// Deterministic gradient placeholder used wherever a network image would live.
///
/// The seed hashes into a stable pair of colors from a curated palette, so the
/// venue card you see at first load matches the one shown after a hot reload
/// — important because gradients are how this prototype carries "image" identity.
class GradientImagePlaceholder extends StatelessWidget {
  const GradientImagePlaceholder({
    required this.seed,
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.overrideGradient,
    this.child,
  });

  final String seed;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final List<int>? overrideGradient;
  final Widget? child;

  static const List<List<int>> _palette = [
    [0xFF3A2A1A, 0xFF1A1410], // ember
    [0xFF2B1B2C, 0xFF120C1A], // plum
    [0xFF1A2640, 0xFF0C111E], // midnight
    [0xFF1F3D33, 0xFF0C1A14], // forest
    [0xFF4A2E1F, 0xFF1A0E08], // burnt sienna
    [0xFF2B2A4A, 0xFF12121F], // ink
    [0xFF3B3022, 0xFF161208], // brass
    [0xFF14232E, 0xFF080C10], // slate
  ];

  List<int> _resolveStops() {
    if (overrideGradient != null && overrideGradient!.length >= 2) {
      return overrideGradient!;
    }
    // FNV-1a 32-bit hash for stable seed → palette index.
    var hash = 2166136261;
    for (final code in seed.codeUnits) {
      hash = (hash ^ code) & 0xFFFFFFFF;
      hash = (hash * 16777619) & 0xFFFFFFFF;
    }
    return _palette[hash % _palette.length];
  }

  @override
  Widget build(BuildContext context) {
    final stops = _resolveStops();
    final radius = borderRadius ?? BorderRadius.circular(AppRadii.xl);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(stops[0]), Color(stops[1])],
        ),
      ),
      child: child,
    );
  }
}
