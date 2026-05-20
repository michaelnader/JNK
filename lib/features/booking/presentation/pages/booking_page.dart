import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/booking_form.dart';
import '../../../../data/models/venue.dart';
import '../../../../domain/repositories/reservation_repository.dart';
import '../../../../domain/repositories/venue_repository.dart';
import '../../../../shared/widgets/glass/ambient_background.dart';
import '../../../../shared/widgets/glass/glass_button.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../blocs/booking_bloc.dart';
import '../widgets/booking_summary_card.dart';
import '../widgets/date_time_picker_sheet.dart';
import '../widgets/guest_count_stepper.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({required this.venueId, super.key});

  final String venueId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingBloc>(
      create: (context) => BookingBloc(
        repository: context.read<ReservationRepository>(),
      )..add(BookingStarted(venueId)),
      child: _BookingScaffold(venueId: venueId),
    );
  }
}

class _BookingScaffold extends StatelessWidget {
  const _BookingScaffold({required this.venueId});
  final String venueId;

  @override
  Widget build(BuildContext context) {
    final venueRepo = context.read<VenueRepository>();
    final venue = venueRepo.findById(venueId);
    return BlocConsumer<BookingBloc, BookingState>(
      listenWhen: (prev, cur) => cur is BookingSuccess,
      listener: (context, state) {
        if (state is BookingSuccess) {
          context.go('/booking-success', extra: state.reservation);
        }
      },
      builder: (context, state) {
        if (venue == null) {
          return const _NotFoundScaffold();
        }
        return AmbientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: _BookingBody(venue: venue, state: state),
            ),
          ),
        );
      },
    );
  }
}

class _BookingBody extends StatelessWidget {
  const _BookingBody({required this.venue, required this.state});

  final Venue venue;
  final BookingState state;

  BookingForm? get _form {
    final s = state;
    if (s is BookingInProgress) return s.form;
    if (s is BookingSubmitting) return s.form;
    if (s is BookingFailure) return s.form;
    return null;
  }

  bool get _isSubmitting => state is BookingSubmitting;
  bool get _isValid => _form?.isValid == true;
  String? get _error => state is BookingFailure
      ? (state as BookingFailure).message
      : null;

  @override
  Widget build(BuildContext context) {
    final form = _form;
    if (form == null) {
      return const Center(child: CircularProgressIndicator(color: AppColors.gold));
    }
    final theme = Theme.of(context);
    return Column(
      children: [
        _Header(venue: venue),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              BookingSummaryCard(venue: venue, form: form),
              const SizedBox(height: AppSpacing.xl),
              _RowField(
                label: 'When',
                value: form.dateTime == null
                    ? 'Choose a date'
                    : AppDateFormat.full(form.dateTime!),
                icon: Icons.event_outlined,
                onTap: () async {
                  final picked = await showDateTimePickerSheet(
                    context,
                    initial: form.dateTime ?? DateTime.now(),
                  );
                  if (picked != null && context.mounted) {
                    context.read<BookingBloc>().add(DateTimePicked(picked));
                  }
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.lg,
                ),
                elevated: false,
                child: Row(
                  children: [
                    const Icon(
                      Icons.group_outlined,
                      color: AppColors.gold,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GUESTS',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            form.guestCount >= 6
                                ? '${form.guestCount} · VIP bypass'
                                : '${form.guestCount}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GuestCountStepper(
                      count: form.guestCount,
                      onChanged: (v) => context
                          .read<BookingBloc>()
                          .add(GuestCountChanged(v)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                elevated: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SPECIAL REQUESTS',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      maxLines: 3,
                      style: theme.textTheme.bodyMedium,
                      cursorColor: AppColors.gold,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Window seat · anniversary · dietary notes…',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      onChanged: (v) => context
                          .read<BookingBloc>()
                          .add(SpecialRequestsChanged(v)),
                    ),
                  ],
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  _error!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.danger),
                ),
              ],
              const SizedBox(height: AppSpacing.xl2),
              GlassButton(
                label: _isSubmitting
                    ? 'Securing your table…'
                    : 'Confirm reservation',
                variant: GlassButtonVariant.gold,
                fullWidth: true,
                loading: _isSubmitting,
                onPressed: _isValid && !_isSubmitting
                    ? () => context
                        .read<BookingBloc>()
                        .add(const ReservationSubmitted())
                    : null,
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }
}

class _RowField extends StatelessWidget {
  const _RowField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.lg),
      elevated: false,
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 18),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.venue});
  final Venue venue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          _BackButton(),
          const Spacer(),
          Text(
            venue.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.charcoal.withValues(alpha: 0.6),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: const Icon(
          Icons.close_rounded,
          color: AppColors.textPrimary,
          size: 20,
        ),
      ),
    );
  }
}

class _NotFoundScaffold extends StatelessWidget {
  const _NotFoundScaffold();
  @override
  Widget build(BuildContext context) {
    return AmbientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl2),
            child: Text(
              'Venue not found.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
