import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/event.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../shared/widgets/common/gradient_image_placeholder.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({
    required this.event,
    required this.onRsvp,
    required this.onDismiss,
    super.key,
  });

  final Event event;
  final VoidCallback onRsvp;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const repo = InMemoryVenueRepository();
    final venue = repo.findById(event.venueId);

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadii.xl),
            ),
            child: SizedBox(
              height: 130,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GradientImagePlaceholder(
                    seed: '${event.id}_${event.venueId}',
                    overrideGradient: venue?.gradient,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: GlassChip(
                      label: AppDateFormat.relative(event.startsAt),
                      icon: Icons.event_outlined,
                      selected: true,
                      tint: AppColors.gold,
                    ),
                  ),
                  if (event.isExclusive)
                    Positioned(
                      top: AppSpacing.md,
                      right: AppSpacing.md,
                      child: GlassChip(
                        label: '${event.capacityRemaining} seats left',
                        icon: Icons.lock_outline,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  event.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: event.tags
                      .map((t) => GlassChip(label: '#$t'))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onDismiss,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          foregroundColor: AppColors.textSecondary,
                        ),
                        child: Text(
                          'Not for me',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.textSecondary,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: FilledButton(
                        onPressed: onRsvp,
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              AppColors.gold.withValues(alpha: 0.18),
                          foregroundColor: AppColors.gold,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadii.pill),
                            side: BorderSide(
                              color: AppColors.gold.withValues(alpha: 0.55),
                            ),
                          ),
                        ),
                        child: Text(
                          'RSVP',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
