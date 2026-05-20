import 'package:flutter/material.dart';

import '../../../app/constants.dart';
import 'glass_container.dart';

/// A tappable glass surface for content blocks (venue cards, summary tiles,
/// list rows). Wraps [GlassContainer] with hit-testing and a press scale.
class GlassCard extends StatefulWidget {
  const GlassCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.borderRadius,
    this.elevated = true,
    this.tintColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  /// When false the heavy drop shadow is omitted (use for cards stacked on
  /// already-glassy surfaces, like inside a modal).
  final bool elevated;

  /// Optional tint applied to the fill + border (e.g. [AppColors.gold] for
  /// emphasis). Defaults to white.
  final Color? tintColor;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: AppDurations.fast,
    lowerBound: 0,
    upperBound: 1,
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _setPressed(bool pressed) {
    if (pressed) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(AppRadii.xl);

    final container = GlassContainer(
      borderRadius: radius,
      padding: widget.padding,
      tintColor: widget.tintColor ?? Colors.white,
      shadows: widget.elevated
          ? null
          : const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
      child: widget.child,
    );

    if (widget.onTap == null) return container;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final scale = 1 - (_ctrl.value * 0.015);
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: widget.onTap,
        child: container,
      ),
    );
  }
}
