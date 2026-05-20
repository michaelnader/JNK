import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants.dart';
import '../../../../data/models/venue.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../shared/widgets/common/gradient_image_placeholder.dart';
import '../../../../shared/widgets/common/section_header.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';

class VenuesListPage extends StatelessWidget {
  const VenuesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const repo = InMemoryVenueRepository();
    final venues = repo.getAll();
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Plus-Plus Venues',
              subtitle:
                  'A short list. Each is a room with a story; tap to read it.',
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.sm,
              AppSpacing.xl,
              140,
            ),
            sliver: SliverList.separated(
              itemCount: venues.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),
              itemBuilder: (context, i) => _VenueRow(venue: venues[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _VenueRow extends StatelessWidget {
  const _VenueRow({required this.venue});

  final Venue venue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      onTap: () => context.go('/venues/${venue.id}'),
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadii.xl),
              bottomLeft: Radius.circular(AppRadii.xl),
            ),
            child: GradientImagePlaceholder(
              seed: venue.id,
              overrideGradient: venue.gradient,
              width: 120,
              height: 160,
              borderRadius: BorderRadius.zero,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          venue.plusPlusName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_outward,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    venue.tagline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      GlassChip(
                        label: venue.neighbourhood,
                        icon: Icons.place_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
