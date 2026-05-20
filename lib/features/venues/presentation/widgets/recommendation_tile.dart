import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../data/models/venue.dart';
import '../../../../shared/widgets/glass/glass_card.dart';

/// Resolves a Material icon by name (we keep VenueRecommendation icons as
/// strings so the data layer stays free of Flutter imports).
IconData _iconFromName(String? name) {
  switch (name) {
    case 'content_cut':
      return Icons.content_cut;
    case 'menu_book':
      return Icons.menu_book;
    case 'nightlife':
      return Icons.nightlife;
    case 'local_cafe':
      return Icons.local_cafe;
    case 'spa':
      return Icons.spa;
    case 'music_note':
      return Icons.music_note;
    case 'casino':
      return Icons.casino;
    case 'cake':
      return Icons.cake;
    case 'camera_alt':
      return Icons.camera_alt_outlined;
    case 'graphic_eq':
      return Icons.graphic_eq;
    case 'ramen_dining':
      return Icons.ramen_dining;
    case 'directions_walk':
      return Icons.directions_walk;
    default:
      return Icons.bookmark_border_rounded;
  }
}

class RecommendationTile extends StatelessWidget {
  const RecommendationTile({
    required this.recommendation,
    super.key,
  });

  final VenueRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      elevated: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.35),
              ),
            ),
            child: Icon(
              _iconFromName(recommendation.icon),
              color: AppColors.gold,
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  recommendation.subtitle,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.gold,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  recommendation.detail,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
