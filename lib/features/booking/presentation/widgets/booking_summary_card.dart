import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/booking_form.dart';
import '../../../../data/models/venue.dart';
import '../../../../shared/widgets/glass/glass_card.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({
    required this.venue,
    required this.form,
    super.key,
  });

  final Venue venue;
  final BookingForm form;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      tintColor: AppColors.gold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR RESERVATION',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            venue.plusPlusName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            venue.neighbourhood,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _Row(
            icon: Icons.calendar_today_rounded,
            label: form.dateTime == null
                ? '—'
                : AppDateFormat.full(form.dateTime!),
          ),
          const SizedBox(height: AppSpacing.sm),
          _Row(
            icon: Icons.group_outlined,
            label:
                '${form.guestCount} ${form.guestCount == 1 ? 'guest' : 'guests'}',
          ),
          if (form.specialRequests.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _Row(
              icon: Icons.edit_note_outlined,
              label: form.specialRequests,
            ),
          ],
          if (form.guestCount >= 6) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt, color: AppColors.gold, size: 16),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'VIP bypass — your party of ${form.guestCount} skips the '
                      'manual screening queue.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
