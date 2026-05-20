import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../data/models/venue.dart';
import 'recommendation_tile.dart';

class PlusPlusSection extends StatelessWidget {
  const PlusPlusSection({
    required this.title,
    required this.intro,
    required this.recommendations,
    super.key,
  });

  final String title;
  final String intro;
  final List<VenueRecommendation> recommendations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl2,
        AppSpacing.xl,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 1,
                color: AppColors.gold.withValues(alpha: 0.65),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.gold,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            intro,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (var i = 0; i < recommendations.length; i++) ...[
            RecommendationTile(recommendation: recommendations[i]),
            if (i != recommendations.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}
