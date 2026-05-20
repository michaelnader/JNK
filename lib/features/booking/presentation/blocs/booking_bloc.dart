import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/booking_form.dart';
import '../../../../data/models/reservation.dart';
import '../../../../domain/repositories/reservation_repository.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

class BookingStarted extends BookingEvent {
  const BookingStarted(this.venueId);
  final String venueId;
  @override
  List<Object?> get props => [venueId];
}

class DateTimePicked extends BookingEvent {
  const DateTimePicked(this.value);
  final DateTime value;
  @override
  List<Object?> get props => [value];
}

class GuestCountChanged extends BookingEvent {
  const GuestCountChanged(this.value);
  final int value;
  @override
  List<Object?> get props => [value];
}

class SpecialRequestsChanged extends BookingEvent {
  const SpecialRequestsChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class ReservationSubmitted extends BookingEvent {
  const ReservationSubmitted();
}

// ---------------------------------------------------------------------------
// States
// ---------------------------------------------------------------------------

abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {
  const BookingInitial();
}

class BookingInProgress extends BookingState {
  const BookingInProgress(this.form);
  final BookingForm form;
  bool get isValid => form.isValid;
  @override
  List<Object?> get props => [form];
}

class BookingSubmitting extends BookingState {
  const BookingSubmitting(this.form);
  final BookingForm form;
  @override
  List<Object?> get props => [form];
}

class BookingSuccess extends BookingState {
  const BookingSuccess(this.reservation);
  final Reservation reservation;
  @override
  List<Object?> get props => [reservation];
}

class BookingFailure extends BookingState {
  const BookingFailure(this.form, this.message);
  final BookingForm form;
  final String message;
  @override
  List<Object?> get props => [form, message];
}

// ---------------------------------------------------------------------------
// Bloc
// ---------------------------------------------------------------------------

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({required ReservationRepository repository})
      : _repo = repository,
        super(const BookingInitial()) {
    on<BookingStarted>(_onStarted);
    on<DateTimePicked>(_onDateTimePicked);
    on<GuestCountChanged>(_onGuestCountChanged);
    on<SpecialRequestsChanged>(_onSpecialRequestsChanged);
    on<ReservationSubmitted>(_onSubmitted);
  }

  final ReservationRepository _repo;

  BookingForm? _currentForm() {
    final s = state;
    if (s is BookingInProgress) return s.form;
    if (s is BookingSubmitting) return s.form;
    if (s is BookingFailure) return s.form;
    return null;
  }

  void _onStarted(BookingStarted e, Emitter<BookingState> emit) {
    final defaultDateTime = _nextEveningSlot();
    emit(
      BookingInProgress(
        BookingForm(
          venueId: e.venueId,
          dateTime: defaultDateTime,
        ),
      ),
    );
  }

  void _onDateTimePicked(DateTimePicked e, Emitter<BookingState> emit) {
    final form = _currentForm();
    if (form == null) return;
    emit(BookingInProgress(form.copyWith(dateTime: e.value)));
  }

  void _onGuestCountChanged(
    GuestCountChanged e,
    Emitter<BookingState> emit,
  ) {
    final form = _currentForm();
    if (form == null) return;
    final clamped = e.value.clamp(1, 12);
    emit(BookingInProgress(form.copyWith(guestCount: clamped)));
  }

  void _onSpecialRequestsChanged(
    SpecialRequestsChanged e,
    Emitter<BookingState> emit,
  ) {
    final form = _currentForm();
    if (form == null) return;
    emit(BookingInProgress(form.copyWith(specialRequests: e.value)));
  }

  Future<void> _onSubmitted(
    ReservationSubmitted e,
    Emitter<BookingState> emit,
  ) async {
    final form = _currentForm();
    if (form == null || !form.isValid) {
      if (form != null) {
        emit(
          BookingFailure(form, 'Pick a future date and 1–12 guests to continue.'),
        );
      }
      return;
    }
    emit(BookingSubmitting(form));
    try {
      final res = await _repo.submit(
        venueId: form.venueId,
        dateTime: form.dateTime!,
        guestCount: form.guestCount,
        specialRequests: form.specialRequests,
      );
      emit(BookingSuccess(res));
    } catch (err) {
      emit(BookingFailure(form, 'Something went wrong. Please try again.'));
    }
  }
}

/// Default opening slot — next evening at 20:00.
DateTime _nextEveningSlot() {
  final now = DateTime.now();
  final target = DateTime(now.year, now.month, now.day, 20);
  if (target.isBefore(now.add(const Duration(hours: 2)))) {
    return target.add(const Duration(days: 1));
  }
  return target;
}
