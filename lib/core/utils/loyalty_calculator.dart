import '../../data/models/reservation.dart';
import '../../data/models/user.dart';

class LoyaltySnapshot {
  const LoyaltySnapshot({
    required this.points,
    required this.currentTier,
    required this.nextTier,
    required this.pointsToNext,
    required this.progressToNext,
  });

  final int points;
  final LoyaltyTier currentTier;

  /// Null when the user is already in the top tier ([LoyaltyTier.obsidian]).
  final LoyaltyTier? nextTier;

  final int pointsToNext;

  /// 0..1 progress from the *start* of the current tier toward the next.
  final double progressToNext;
}

/// Pure functions: no Flutter, no async, no IO. Easy to unit-test.
class LoyaltyCalculator {
  const LoyaltyCalculator();

  /// Points awarded per reservation.
  ///   base 50, +10 per guest, +25 VIP bypass bonus
  int pointsFor(Reservation r) {
    final base = 50 + (r.guestCount * 10);
    final bonus = r.status == ReservationStatus.vipBypassed ? 25 : 0;
    return base + bonus;
  }

  int totalPoints(Iterable<Reservation> reservations) =>
      reservations.fold(0, (sum, r) => sum + pointsFor(r));

  LoyaltySnapshot snapshot(Iterable<Reservation> reservations) {
    final points = totalPoints(reservations);
    final tiers = LoyaltyTier.values;
    LoyaltyTier current = tiers.first;
    for (final t in tiers) {
      if (points >= t.minPoints) current = t;
    }
    final idx = tiers.indexOf(current);
    final next = idx + 1 < tiers.length ? tiers[idx + 1] : null;

    if (next == null) {
      return LoyaltySnapshot(
        points: points,
        currentTier: current,
        nextTier: null,
        pointsToNext: 0,
        progressToNext: 1.0,
      );
    }

    final spread = next.minPoints - current.minPoints;
    final into = points - current.minPoints;
    final progress = spread == 0 ? 1.0 : (into / spread).clamp(0.0, 1.0);
    return LoyaltySnapshot(
      points: points,
      currentTier: current,
      nextTier: next,
      pointsToNext: next.minPoints - points,
      progressToNext: progress,
    );
  }
}
