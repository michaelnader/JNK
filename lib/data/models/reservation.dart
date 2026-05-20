import 'package:equatable/equatable.dart';

enum ReservationStatus {
  pending(label: 'Pending'),
  approved(label: 'Approved'),
  vipBypassed(label: 'VIP Bypass');

  const ReservationStatus({required this.label});

  final String label;
}

class Reservation extends Equatable {
  const Reservation({
    required this.id,
    required this.venueId,
    required this.dateTime,
    required this.guestCount,
    required this.status,
    this.specialRequests = '',
  });

  final String id;
  final String venueId;
  final DateTime dateTime;
  final int guestCount;
  final ReservationStatus status;
  final String specialRequests;

  Reservation copyWith({
    String? id,
    String? venueId,
    DateTime? dateTime,
    int? guestCount,
    ReservationStatus? status,
    String? specialRequests,
  }) {
    return Reservation(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      dateTime: dateTime ?? this.dateTime,
      guestCount: guestCount ?? this.guestCount,
      status: status ?? this.status,
      specialRequests: specialRequests ?? this.specialRequests,
    );
  }

  @override
  List<Object?> get props =>
      [id, venueId, dateTime, guestCount, status, specialRequests];
}
