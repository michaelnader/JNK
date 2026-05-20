import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../shared/widgets/glass/glass_button.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';
import '../blocs/venue_detail_cubit.dart';
import '../widgets/plus_plus_section.dart';
import '../widgets/venue_story_header.dart';

class VenueDetailPage extends StatelessWidget {
  const VenueDetailPage({required this.venueId, super.key});

  final String venueId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VenueDetailCubit>(
      create: (_) => VenueDetailCubit(
        repository: const InMemoryVenueRepository(),
      )..load(venueId),
      child: const _VenueDetailScaffold(),
    );
  }
}

class _VenueDetailScaffold extends StatelessWidget {
  const _VenueDetailScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueDetailCubit, VenueDetailState>(
      builder: (context, state) {
        if (state is VenueDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        }
        if (state is VenueDetailNotFound) {
          return Center(
            child: Text(
              "We couldn't find that venue.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        final venue = (state as VenueDetailLoaded).venue;
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: VenueStoryHeader(venue: venue)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.xl,
                      AppSpacing.xl,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                height: 1.6,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            GlassChip(
                              label: venue.signatureDish,
                              icon: Icons.local_dining_outlined,
                            ),
                            const GlassChip(
                              label: '360° tour',
                              icon: Icons.threed_rotation,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.xl2,
                      AppSpacing.xl,
                      0,
                    ),
                    child: GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      tintColor: AppColors.midnight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 1,
                                color: AppColors.platinum
                                    .withValues(alpha: 0.55),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'THE STORY',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.platinum,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            venue.history,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.7,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: PlusPlusSection(
                    title: 'Before the room',
                    intro:
                        'Curated arrivals — small rituals to soften the evening '
                        'before you cross the threshold.',
                    recommendations: venue.preEventRecommendations,
                  ),
                ),
                SliverToBoxAdapter(
                  child: PlusPlusSection(
                    title: 'After the room',
                    intro:
                        'The night doesn\'t end at the door. A handful of next '
                        'moves the concierge has held back for you.',
                    recommendations: venue.postEventRecommendations,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 180)),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    children: [
                      _CircularGlassIcon(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => context.go('/venues'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              bottom: AppSpacing.lg + 90,
              child: GlassButton(
                label: 'Reserve at ${venue.name}',
                variant: GlassButtonVariant.gold,
                fullWidth: true,
                trailingIcon: Icons.arrow_forward_rounded,
                onPressed: () => context.go('/venues/${venue.id}/book'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CircularGlassIcon extends StatelessWidget {
  const _CircularGlassIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.charcoal.withValues(alpha: 0.65),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }
}
