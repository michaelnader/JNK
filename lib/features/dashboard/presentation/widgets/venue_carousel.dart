import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../data/models/venue.dart';
import '../../../../shared/widgets/common/gradient_image_placeholder.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';

class VenueCarousel extends StatelessWidget {
  const VenueCarousel({
    required this.venues,
    required this.onVenueTap,
    required this.onBookTap,
    super.key,
  });

  final List<Venue> venues;
  final ValueChanged<Venue> onVenueTap;
  final ValueChanged<Venue> onBookTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        itemCount: venues.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, i) {
          final v = venues[i];
          return RepaintBoundary(
            child: _VenueCarouselCard(
              venue: v,
              onTap: () => onVenueTap(v),
              onBookTap: () => onBookTap(v),
            ),
          );
        },
      ),
    );
  }
}

class _VenueCarouselCard extends StatelessWidget {
  const _VenueCarouselCard({
    required this.venue,
    required this.onTap,
    required this.onBookTap,
  });

  final Venue venue;
  final VoidCallback onTap;
  final VoidCallback onBookTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GradientImagePlaceholder(
              seed: venue.id,
              overrideGradient: venue.gradient,
              borderRadius: BorderRadius.circular(AppRadii.xl2),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadii.xl2),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.obsidianDeep.withValues(alpha: 0.65),
                      AppColors.obsidianDeep.withValues(alpha: 0.92),
                    ],
                    stops: const [0.35, 0.7, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GlassChip(
                        label: venue.neighbourhood,
                        icon: Icons.place_outlined,
                        tint: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    venue.plusPlusName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    venue.tagline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  GlassCard(
                    onTap: onBookTap,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                    tintColor: AppColors.gold,
                    elevated: false,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt, size: 16, color: AppColors.gold),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Reserve a table',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
