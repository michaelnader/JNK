import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../shared/widgets/common/section_header.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';
import '../blocs/invites_cubit.dart';
import '../widgets/empty_invites_state.dart';
import '../widgets/invite_card.dart';

class InvitesPage extends StatelessWidget {
  const InvitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitesCubit, InvitesState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        }
        final allTags = state.matched
            .expand((e) => e.tags)
            .toSet()
            .toList()
          ..sort();
        final events = state.visible;

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
                        'EXCLUSIVE INVITES',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Tailored from your interests',
                        style: context.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.lg,
                    AppSpacing.xl,
                    AppSpacing.md,
                  ),
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: allTags.map((t) {
                      final on = state.activeFilters.contains(t);
                      return GlassChip(
                        label: '#$t',
                        selected: on,
                        onTap: () =>
                            context.read<InvitesCubit>().toggleFilter(t),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (events.isEmpty)
                const SliverToBoxAdapter(child: EmptyInvitesState())
              else ...[
                const SliverToBoxAdapter(
                  child: SectionHeader(
                    title: 'Coming up',
                    subtitle: 'Ranked by how closely they match you',
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
                    itemCount: events.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, i) => InviteCard(
                      event: events[i],
                      onRsvp: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.charcoal,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'You\'re in. We\'ll send a discreet reminder.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                        );
                      },
                      onDismiss: () => context
                          .read<InvitesCubit>()
                          .dismiss(events[i].id),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
