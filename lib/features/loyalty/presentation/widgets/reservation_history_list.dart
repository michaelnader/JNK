import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/reservation.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';

class ReservationHistoryList extends StatelessWidget {
  const ReservationHistoryList({required this.history, super.key});

  final List<Reservation> history;

  @override
  Widget build(BuildContext context) {
    const repo = InMemoryVenueRepository();
    return Column(
      children: [
        for (var i = 0; i < history.length; i++) ...[
          _HistoryRow(
            reservation: history[i],
            venueName:
                repo.findById(history[i].venueId)?.plusPlusName ?? 'Venue',
          ),
          if (i != history.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.reservation, required this.venueName});

  final Reservation reservation;
  final String venueName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      elevated: false,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venueName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${AppDateFormat.shortDateTime(reservation.dateTime)}'
                  ' · ${reservation.guestCount} guests',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GlassChip(
            label: reservation.status.label,
            selected: reservation.status != ReservationStatus.pending,
            tint: reservation.status == ReservationStatus.vipBypassed
                ? AppColors.gold
                : null,
            icon: reservation.status == ReservationStatus.vipBypassed
                ? Icons.bolt
                : Icons.check_circle_outline_rounded,
          ),
        ],
      ),
    );
  }
}
