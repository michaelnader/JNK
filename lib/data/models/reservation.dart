import 'package:equatable/equatable.dart';

enum ReservationStatus { confirmed, past, cancelled }

class Reservation extends Equatable {
  const Reservation({
    required this.id,
    required this.restaurantId,
    required this.dateTime,
    required this.guestCount,
    required this.status,
    this.note,
  });

  final String id;
  final String restaurantId;
  final DateTime dateTime;
  final int guestCount;
  final ReservationStatus status;
  final String? note;

  @override
  List<Object?> get props =>
      [id, restaurantId, dateTime, guestCount, status, note];
}
