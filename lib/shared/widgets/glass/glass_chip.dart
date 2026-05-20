import 'package:flutter/material.dart';

import '../../../app/constants.dart';
import 'glass_container.dart';

/// Compact glass pill used for interest tags, filter chips, status badges.
class GlassChip extends StatelessWidget {
  const GlassChip({
    required this.label,
    super.key,
    this.icon,
    this.selected = false,
    this.onTap,
    this.tint,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = tint ?? (selected ? AppColors.gold : Colors.white);

    final body = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: accent.withValues(alpha: 0.9)),
          const SizedBox(width: AppSpacing.xs + 2),
        ],
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: selected ? AppColors.textPrimary : AppColors.textSecondary,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    final chip = GlassContainer(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md + 2,
        vertical: AppSpacing.xs + 2,
      ),
      tintColor: accent,
      fillOpacity: selected ? 0.14 : 0.06,
      borderOpacity: selected ? 0.45 : 0.12,
      shadows: const [],
      enableInnerHighlight: false,
      child: body,
    );

    if (onTap == null) return chip;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: chip,
    );
  }
}
