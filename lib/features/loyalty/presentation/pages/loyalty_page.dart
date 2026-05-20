import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../data/models/user.dart';
import '../../../../shared/widgets/common/section_header.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';
import '../blocs/loyalty_cubit.dart';
import '../widgets/reservation_history_list.dart';
import '../widgets/tier_progress_arc.dart';

class LoyaltyPage extends StatelessWidget {
  const LoyaltyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoyaltyCubit, LoyaltyState>(
      builder: (context, state) {
        if (state.loading ||
            state.user == null ||
            state.snapshot == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        }
        final user = state.user!;
        final snap = state.snapshot!;
        return SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
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
                        'LOYALTY',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        user.firstName,
                        style: context.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
              SliverToBoxAdapter(
                child: Center(child: TierProgressArc(snapshot: snap)),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: GlassCard(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _TierBadge(tier: snap.currentTier),
                            const Spacer(),
                            if (snap.nextTier != null)
                              Text(
                                'Next · ${snap.nextTier!.label}',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.2,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          snap.nextTier == null
                              ? 'You\'ve reached Obsidian — the top tier in the '
                                  'Privilege Club.'
                              : '${snap.pointsToNext} points away from '
                                  '${snap.nextTier!.label}. Each reservation '
                                  'gives you 50 base points + 10 per guest, '
                                  'with a 25-pt bonus on VIP bypass.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Reservation log',
                  subtitle: 'How your points are accruing',
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  140,
                ),
                sliver: SliverToBoxAdapter(
                  child: ReservationHistoryList(history: state.history),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TierBadge extends StatelessWidget {
  const _TierBadge({required this.tier});
  final LoyaltyTier tier;

  Color _color() {
    switch (tier) {
      case LoyaltyTier.silver:
        return AppColors.tierSilver;
      case LoyaltyTier.gold:
        return AppColors.tierGold;
      case LoyaltyTier.platinum:
        return AppColors.tierPlatinum;
      case LoyaltyTier.obsidian:
        return AppColors.tierObsidian;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassChip(
      label: '${tier.label} member',
      icon: Icons.diamond_outlined,
      tint: _color(),
      selected: true,
    );
  }
}
