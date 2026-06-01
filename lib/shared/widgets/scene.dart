import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/constants.dart';

enum SceneTone { grey, photo, dark }

/// Off Duty screen background — equivalent of the prototype's `ScreenBg5`.
///
/// Three tones:
/// - [SceneTone.grey] — Soft Cream → Warm Sand gradient with vignette + noise.
/// - [SceneTone.photo] — monochrome restaurant photo behind a Deep Denim tint
///   and a top-to-bottom legibility wash.
/// - [SceneTone.dark] — Charcoal flat surface for booking-flow steps.
class AppScene extends StatelessWidget {
  const AppScene({
    super.key,
    required this.child,
    this.tone = SceneTone.grey,
    this.photoAsset,
  });

  final Widget child;
  final SceneTone tone;
  final String? photoAsset;

  @override
  Widget build(BuildContext context) {
    final usePhoto = tone == SceneTone.photo && photoAsset != null;
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base canvas
        if (tone == SceneTone.dark)
          Container(color: AppColors.charcoal)
        else
          const DecoratedBox(
            decoration: BoxDecoration(gradient: appSceneGradient),
          ),
        // Photo layer
        if (usePhoto) ...[
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: AppPhoto.monoFilter,
              child: Image.asset(photoAsset!, fit: BoxFit.cover),
            ),
          ),
          // Slate-blue tint
          const Positioned.fill(
            child: ColoredBox(color: AppPhoto.monoTint),
          ),
          // Legibility wash — bottom-darker
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
          ),
        ],
        // Soft vignette + ambient noise (the "material" feel)
        const Positioned.fill(child: IgnorePointer(child: _Vignette())),
        // Content
        Positioned.fill(child: child),
      ],
    );
  }
}

class _Vignette extends StatelessWidget {
  const _Vignette();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Top highlight + bottom shadow
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -1.05),
              radius: 1.0,
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.transparent,
              ],
              stops: const [0, 0.6],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, 1.05),
              radius: 0.95,
              colors: [
                Colors.black.withValues(alpha: 0.22),
                Colors.transparent,
              ],
              stops: const [0, 0.55],
            ),
          ),
        ),
      ],
    );
  }
}

/// A static helper that mimics the prototype's monochrome photo treatment for
/// any image asset — used by avatars and small photo cards.
class MonoPhoto extends StatelessWidget {
  const MonoPhoto({
    super.key,
    required this.asset,
    this.fit = BoxFit.cover,
  });

  final String asset;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: AppPhoto.monoFilter,
          child: Image.asset(asset, fit: fit),
        ),
        const ColoredBox(color: AppPhoto.monoTint),
      ],
    );
  }
}

// Re-export so callers don't need to import dart:ui just for ImageFilter.
typedef Blur = ImageFilter;
