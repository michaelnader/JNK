import 'dart:async';

import '../../data/mock/mock_reservations.dart';
import '../../data/models/reservation.dart';

/// Reactive store for user reservations. New submissions flow through
/// [submit] and immediately broadcast via [watchAll] so the loyalty + dashboard
/// cubits update without a manual refresh.
abstract interface class ReservationRepository {
  List<Reservation> getAll();
  Stream<List<Reservation>> watchAll();
  Future<Reservation> submit({
    required String venueId,
    required DateTime dateTime,
    required int guestCount,
    String specialRequests = '',
  });
}

class InMemoryReservationRepository implements ReservationRepository {
  InMemoryReservationRepository() {
    _reservations = List.of(mockReservations);
    _controller.add(List.unmodifiable(_reservations));
  }

  late final List<Reservation> _reservations;
  final StreamController<List<Reservation>> _controller =
      StreamController<List<Reservation>>.broadcast();

  @override
  List<Reservation> getAll() => List.unmodifiable(_reservations);

  @override
  Stream<List<Reservation>> watchAll() async* {
    yield List.unmodifiable(_reservations);
    yield* _controller.stream;
  }

  @override
  Future<Reservation> submit({
    required String venueId,
    required DateTime dateTime,
    required int guestCount,
    String specialRequests = '',
  }) async {
    // Simulate network latency so the booking UI can show its submitting state.
    await Future<void>.delayed(const Duration(milliseconds: 850));

    // VIP heuristic for the demo: parties of 6+ are auto-bypassed.
    final status = guestCount >= 6
        ? ReservationStatus.vipBypassed
        : ReservationStatus.approved;

    final reservation = Reservation(
      id: 'res_${DateTime.now().microsecondsSinceEpoch}',
      venueId: venueId,
      dateTime: dateTime,
      guestCount: guestCount,
      status: status,
      specialRequests: specialRequests,
    );
    _reservations.add(reservation);
    _controller.add(List.unmodifiable(_reservations));
    return reservation;
  }

  Future<void> dispose() => _controller.close();
}
