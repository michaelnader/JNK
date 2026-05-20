import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/common/section_header.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';
import '../../../app_mode/bloc/app_mode_cubit.dart';
import '../blocs/dashboard_cubit.dart';
import '../widgets/loyalty_summary_strip.dart';
import '../widgets/venue_carousel.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.loading || state.user == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        }
        final user = state.user!;
        return SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _Greeting(user: user.firstName),
              ),
              if (state.upcomingReservation != null)
                SliverToBoxAdapter(
                  child: _UpcomingReservationStrip(
                    venueName: state.featuredVenues
                            .where(
                              (v) =>
                                  v.id == state.upcomingReservation!.venueId,
                            )
                            .firstOrNull
                            ?.name ??
                        'Reservation',
                    when: state.upcomingReservation!.dateTime,
                    guests: state.upcomingReservation!.guestCount,
                  ),
                ),
              if (state.loyalty != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.md,
                      AppSpacing.xl,
                      0,
                    ),
                    child: LoyaltySummaryStrip(
                      snapshot: state.loyalty!,
                      onTap: () => context.go('/loyalty'),
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Curated tonight',
                  subtitle: 'Hand-picked rooms with a story',
                ),
              ),
              SliverToBoxAdapter(
                child: VenueCarousel(
                  venues: state.featuredVenues,
                  onVenueTap: (v) => context.go('/venues/${v.id}'),
                  onBookTap: (v) => context.go('/venues/${v.id}/book'),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xl),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    0,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  child: _TaliEntryCard(
                    onTap: () =>
                        context.read<AppModeCubit>().enterAdminMode(),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ),
        );
      },
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.user});
  final String user;

  String _salutation() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Good night';
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_salutation()},',
            style: context.textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            user,
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.05,
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingReservationStrip extends StatelessWidget {
  const _UpcomingReservationStrip({
    required this.venueName,
    required this.when,
    required this.guests,
  });

  final String venueName;
  final DateTime when;
  final int guests;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        0,
      ),
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        tintColor: AppColors.gold,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: const Icon(
                Icons.event_available_outlined,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppDateFormat.relative(when),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.gold,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    venueName,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            GlassChip(label: '$guests guests'),
          ],
        ),
      ),
    );
  }
}

class _TaliEntryCard extends StatelessWidget {
  const _TaliEntryCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.midnight,
                  AppColors.midnightSoft.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Open Tali — concierge mode',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  'VIP bypass, virtual tours & AI itinerary',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
