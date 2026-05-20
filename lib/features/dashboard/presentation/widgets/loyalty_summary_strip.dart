import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/loyalty_calculator.dart';
import '../../../../shared/widgets/glass/glass_card.dart';

class LoyaltySummaryStrip extends StatelessWidget {
  const LoyaltySummaryStrip({
    required this.snapshot,
    required this.onTap,
    super.key,
  });

  final LoyaltySnapshot snapshot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final next = snapshot.nextTier;
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.diamond_outlined,
                color: AppColors.gold,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                snapshot.currentTier.label.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.gold,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${snapshot.points} pts',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: LinearProgressIndicator(
              value: snapshot.progressToNext,
              minHeight: 6,
              backgroundColor: AppColors.glassFill,
              valueColor: const AlwaysStoppedAnimation(AppColors.gold),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            next == null
                ? 'You\'ve reached Obsidian — the top tier.'
                : '${snapshot.pointsToNext} pts to ${next.label}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
