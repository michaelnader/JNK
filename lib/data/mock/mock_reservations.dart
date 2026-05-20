import '../models/reservation.dart';

/// Demo user's past reservations. Seeds the loyalty calculator + history list.
final List<Reservation> mockReservations = [
  Reservation(
    id: 'res_001',
    venueId: 'venue_samara',
    dateTime: DateTime(2026, 1, 18, 20, 30),
    guestCount: 4,
    status: ReservationStatus.approved,
    specialRequests: 'Window banquette if available.',
  ),
  Reservation(
    id: 'res_002',
    venueId: 'venue_kikis',
    dateTime: DateTime(2026, 2, 22, 22, 0),
    guestCount: 2,
    status: ReservationStatus.vipBypassed,
  ),
  Reservation(
    id: 'res_003',
    venueId: 'venue_maze',
    dateTime: DateTime(2026, 3, 30, 20, 0),
    guestCount: 6,
    status: ReservationStatus.approved,
    specialRequests: 'Anniversary — please no candles.',
  ),
  Reservation(
    id: 'res_004',
    venueId: 'venue_samara',
    dateTime: DateTime(2026, 4, 25, 21, 0),
    guestCount: 2,
    status: ReservationStatus.approved,
  ),
];
