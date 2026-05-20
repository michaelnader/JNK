import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/constants.dart';

class GuestCountStepper extends StatelessWidget {
  const GuestCountStepper({
    required this.count,
    required this.onChanged,
    super.key,
    this.min = 1,
    this.max = 12,
  });

  final int count;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: Icons.remove_rounded,
            enabled: count > min,
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged((count - 1).clamp(min, max));
            },
          ),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: 32,
            child: Center(
              child: Text(
                '$count',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          _StepperButton(
            icon: Icons.add_rounded,
            enabled: count < max,
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged((count + 1).clamp(min, max));
            },
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: InkResponse(
        radius: 22,
        onTap: enabled ? onTap : null,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.glassFill,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: 16,
          ),
        ),
      ),
    );
  }
}
