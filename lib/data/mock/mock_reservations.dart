import '../models/reservation.dart';

/// Seed bookings for the "My reservations" screen.
final List<Reservation> mockReservations = [
  Reservation(
    id: 'r1',
    restaurantId: 'stanley',
    dateTime: DateTime(2025, 11, 14, 20, 30),
    guestCount: 4,
    status: ReservationStatus.confirmed,
    note: 'Anniversary · Pescatarian',
  ),
  Reservation(
    id: 'r2',
    restaurantId: 'kikis',
    dateTime: DateTime(2025, 11, 22, 14, 0),
    guestCount: 6,
    status: ReservationStatus.confirmed,
    note: 'Cabana for 6',
  ),
  Reservation(
    id: 'r3',
    restaurantId: 'sax',
    dateTime: DateTime(2025, 11, 6, 22, 0),
    guestCount: 2,
    status: ReservationStatus.past,
  ),
];
