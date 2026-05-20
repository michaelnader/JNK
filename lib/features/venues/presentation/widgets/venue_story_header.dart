import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../data/models/venue.dart';
import '../../../../shared/widgets/common/gradient_image_placeholder.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';

class VenueStoryHeader extends StatelessWidget {
  const VenueStoryHeader({required this.venue, super.key});

  final Venue venue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        GradientImagePlaceholder(
          seed: venue.id,
          overrideGradient: venue.gradient,
          height: 460,
          borderRadius: BorderRadius.zero,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.obsidianDeep.withValues(alpha: 0.25),
                  AppColors.obsidianDeep.withValues(alpha: 0.55),
                  AppColors.obsidianDeep,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          left: AppSpacing.xl,
          right: AppSpacing.xl,
          bottom: AppSpacing.xl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GlassChip(
                    label: venue.neighbourhood,
                    icon: Icons.place_outlined,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const GlassChip(
                    label: 'JNK Privilege',
                    icon: Icons.diamond_outlined,
                    tint: AppColors.gold,
                    selected: true,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                venue.plusPlusName,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                venue.tagline,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
