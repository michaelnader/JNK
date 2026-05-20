import 'package:flutter/material.dart';

import '../../../app/constants.dart';

/// Full-screen obsidian canvas with slowly drifting radial light blobs that
/// give every glass surface something to refract.
///
/// Compose with: AmbientBackground(child: Stack(...))
class AmbientBackground extends StatefulWidget {
  const AmbientBackground({
    required this.child,
    super.key,
    this.animated = true,
    this.intensity = 1.0,
  });

  final Widget child;
  final bool animated;

  /// 0..1 multiplier on the blob opacities. Lower this on heavy screens.
  final double intensity;

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: AppDurations.ambient,
  );

  @override
  void initState() {
    super.initState();
    if (widget.animated) _ctrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(AmbientBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animated && !_ctrl.isAnimating) {
      _ctrl.repeat(reverse: true);
    } else if (!widget.animated && _ctrl.isAnimating) {
      _ctrl.stop();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.obsidianDeep),
        const _BaseGradient(),
        AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) {
            final t = _ctrl.value;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BlobPainter(
                      t: t,
                      intensity: widget.intensity,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _BaseGradient extends StatelessWidget {
  const _BaseGradient();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.obsidianDeep,
            AppColors.obsidian,
            AppColors.charcoal,
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({required this.t, required this.intensity});

  final double t;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Gold blob — drifts top-left to top-center
    _paintBlob(
      canvas,
      center: Offset(w * (0.22 + 0.05 * t), h * (0.18 + 0.03 * t)),
      radius: w * 0.55,
      colors: [
        AppColors.gold.withValues(alpha: 0.10 * intensity),
        AppColors.gold.withValues(alpha: 0),
      ],
    );

    // Midnight blob — drifts bottom-right
    _paintBlob(
      canvas,
      center: Offset(w * (0.85 - 0.04 * t), h * (0.78 - 0.04 * t)),
      radius: w * 0.7,
      colors: [
        AppColors.midnight.withValues(alpha: 0.40 * intensity),
        AppColors.midnight.withValues(alpha: 0),
      ],
    );

    // Platinum highlight — small, drifts mid-left
    _paintBlob(
      canvas,
      center: Offset(w * (0.08 + 0.04 * t), h * 0.55),
      radius: w * 0.35,
      colors: [
        AppColors.platinum.withValues(alpha: 0.05 * intensity),
        AppColors.platinum.withValues(alpha: 0),
      ],
    );
  }

  void _paintBlob(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required List<Color> colors,
  }) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..shader = RadialGradient(colors: colors).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) =>
      oldDelegate.t != t || oldDelegate.intensity != intensity;
}
