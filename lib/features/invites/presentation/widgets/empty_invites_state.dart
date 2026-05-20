import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../shared/widgets/glass/glass_card.dart';

class EmptyInvitesState extends StatelessWidget {
  const EmptyInvitesState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.xl2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.nightlife_outlined,
              color: AppColors.gold,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Nothing on the wire — yet.',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'When the next closed event opens, you\'ll see it here first. '
              'Adjust your interest tags to broaden the feed.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
