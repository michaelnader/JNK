import 'package:equatable/equatable.dart';

/// Aggregated state for the 4-step booking wizard.
class BookingForm extends Equatable {
  const BookingForm({
    required this.restaurantId,
    this.guestCount = 2,
    this.date,
    this.time,
    this.occasion,
    this.note = '',
    this.dietary = const {},
  });

  final String restaurantId;
  final int guestCount;
  final DateTime? date;
  final String? time;
  final String? occasion;
  final String note;
  final Set<String> dietary;

  BookingForm copyWith({
    String? restaurantId,
    int? guestCount,
    DateTime? date,
    String? time,
    String? occasion,
    String? note,
    Set<String>? dietary,
  }) =>
      BookingForm(
        restaurantId: restaurantId ?? this.restaurantId,
        guestCount: guestCount ?? this.guestCount,
        date: date ?? this.date,
        time: time ?? this.time,
        occasion: occasion ?? this.occasion,
        note: note ?? this.note,
        dietary: dietary ?? this.dietary,
      );

  @override
  List<Object?> get props =>
      [restaurantId, guestCount, date, time, occasion, note, dietary];
}
