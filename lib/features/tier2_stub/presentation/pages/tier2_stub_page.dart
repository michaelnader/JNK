import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants.dart';
import '../../../../shared/widgets/glass/ambient_background.dart';
import '../../../../shared/widgets/glass/glass_button.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';
import '../../../app_mode/bloc/app_mode_cubit.dart';

class Tier2StubPage extends StatelessWidget {
  const Tier2StubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AmbientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl2),
                child: GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.xl2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const GlassChip(
                            label: 'Tier 2 · Tali',
                            icon: Icons.auto_awesome,
                            tint: AppColors.gold,
                            selected: true,
                          ),
                          const Spacer(),
                          Text(
                            'Soon',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.gold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        'Concierge mode\nis arriving next.',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'VIP reservation flow, 360° virtual tours of the venues '
                        'and their neighbourhoods, plus the Tali itinerary '
                        'concierge — a private AI agent that drafts your '
                        'end-to-end Egypt trip in real time.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          GlassChip(
                            label: 'VIP bypass queue',
                            icon: Icons.bolt,
                          ),
                          GlassChip(
                            label: '360° tours',
                            icon: Icons.threed_rotation,
                          ),
                          GlassChip(
                            label: 'AI itinerary',
                            icon: Icons.chat_bubble_outline,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl2),
                      Row(
                        children: [
                          Expanded(
                            child: GlassButton(
                              label: 'Back to JNK',
                              leadingIcon: Icons.arrow_back_rounded,
                              fullWidth: true,
                              onPressed: () {
                                context.read<AppModeCubit>().enterUserMode();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
