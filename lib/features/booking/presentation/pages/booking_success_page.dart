import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/reservation.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../shared/widgets/glass/ambient_background.dart';
import '../../../../shared/widgets/glass/glass_button.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({required this.reservation, super.key});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const venueRepo = InMemoryVenueRepository();
    final venue = venueRepo.findById(reservation.venueId);
    final venueName = venue?.plusPlusName ?? 'Your venue';

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
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: AppColors.gold,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        reservation.status == ReservationStatus.vipBypassed
                            ? 'VIP bypass confirmed.'
                            : 'You\'re on the list.',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'A confirmation message has been routed to your door '
                        'host. Show this screen on arrival.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _Row(label: 'Venue', value: venueName),
                      const SizedBox(height: AppSpacing.sm),
                      _Row(
                        label: 'When',
                        value: AppDateFormat.full(reservation.dateTime),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _Row(
                        label: 'Guests',
                        value: '${reservation.guestCount}',
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      GlassChip(
                        label: reservation.status.label,
                        icon: reservation.status == ReservationStatus.vipBypassed
                            ? Icons.bolt
                            : Icons.check_circle_outline_rounded,
                        selected: true,
                        tint: AppColors.gold,
                      ),
                      const SizedBox(height: AppSpacing.xl2),
                      GlassButton(
                        label: 'Back to your dashboard',
                        variant: GlassButtonVariant.gold,
                        fullWidth: true,
                        leadingIcon: Icons.dashboard_customize_outlined,
                        onPressed: () => context.go('/dashboard'),
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

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 2,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
