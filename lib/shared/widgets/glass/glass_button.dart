import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/constants.dart';
import 'glass_container.dart';

enum GlassButtonVariant { primary, gold, ghost }

/// Glass-styled action button.
///
/// Variants:
///   * [GlassButtonVariant.primary] — neutral platinum glass
///   * [GlassButtonVariant.gold] — gold-tinted glass with a faint gold border
///     (use for confirm / book actions)
///   * [GlassButtonVariant.ghost] — borderless, no shadow (use inside modals)
class GlassButton extends StatefulWidget {
  const GlassButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = GlassButtonVariant.primary,
    this.loading = false,
    this.fullWidth = false,
    this.leadingIcon,
    this.trailingIcon,
    this.padding,
  });

  final String label;
  final VoidCallback? onPressed;
  final GlassButtonVariant variant;
  final bool loading;
  final bool fullWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final EdgeInsetsGeometry? padding;

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGold = widget.variant == GlassButtonVariant.gold;
    final isGhost = widget.variant == GlassButtonVariant.ghost;

    final tint = isGold ? AppColors.gold : Colors.white;
    final labelColor =
        !_enabled ? AppColors.textTertiary : AppColors.textPrimary;

    final content = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.loading) ...[
          const SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              strokeWidth: 1.6,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ] else if (widget.leadingIcon != null) ...[
          Icon(widget.leadingIcon, size: 18, color: labelColor),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          widget.label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: labelColor,
            letterSpacing: 0.8,
          ),
        ),
        if (widget.trailingIcon != null && !widget.loading) ...[
          const SizedBox(width: AppSpacing.sm),
          Icon(widget.trailingIcon, size: 18, color: labelColor),
        ],
      ],
    );

    final padded = Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl2,
            vertical: AppSpacing.md + 2,
          ),
      child: content,
    );

    final surface = GlassContainer(
      blurSigma: AppGlass.blurSigma,
      borderRadius: BorderRadius.circular(AppRadii.pill),
      padding: EdgeInsets.zero,
      tintColor: tint,
      fillOpacity: isGold ? 0.18 : AppGlass.fillOpacity,
      borderOpacity: isGold ? 0.55 : AppGlass.borderOpacity,
      borderWidth: isGold ? 1.2 : AppGlass.borderWidth,
      shadows: isGhost
          ? const []
          : const [
              BoxShadow(
                color: Color(0x55000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
      overlayGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0.0),
        ],
      ),
      child: padded,
    );

    final scale = _pressed && _enabled ? 0.98 : 1.0;
    final opacity = _enabled ? 1.0 : 0.55;

    return Opacity(
      opacity: opacity,
      child: AnimatedScale(
        scale: scale,
        duration: AppDurations.fast,
        curve: Curves.easeOut,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
          onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
          onTapCancel:
              _enabled ? () => setState(() => _pressed = false) : null,
          onTap: _enabled
              ? () {
                  HapticFeedback.selectionClick();
                  widget.onPressed?.call();
                }
              : null,
          child: surface,
        ),
      ),
    );
  }
}
