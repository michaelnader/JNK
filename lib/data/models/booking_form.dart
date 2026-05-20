import 'package:equatable/equatable.dart';

/// Immutable draft used inside BookingBloc state. The bloc emits a fresh form
/// via [copyWith] on every event — keeping the draft immutable makes time-travel
/// debugging and equality checks trivial.
class BookingForm extends Equatable {
  const BookingForm({
    required this.venueId,
    this.dateTime,
    this.guestCount = 2,
    this.specialRequests = '',
  });

  final String venueId;
  final DateTime? dateTime;
  final int guestCount;
  final String specialRequests;

  bool get isValid =>
      dateTime != null &&
      dateTime!.isAfter(DateTime.now()) &&
      guestCount >= 1 &&
      guestCount <= 12;

  BookingForm copyWith({
    String? venueId,
    DateTime? dateTime,
    int? guestCount,
    String? specialRequests,
  }) {
    return BookingForm(
      venueId: venueId ?? this.venueId,
      dateTime: dateTime ?? this.dateTime,
      guestCount: guestCount ?? this.guestCount,
      specialRequests: specialRequests ?? this.specialRequests,
    );
  }

  @override
  List<Object?> get props => [venueId, dateTime, guestCount, specialRequests];
}
