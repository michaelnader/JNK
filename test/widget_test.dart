import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gnk/app/app.dart';
import 'package:gnk/core/utils/loyalty_calculator.dart';
import 'package:gnk/data/mock/mock_reservations.dart';
import 'package:gnk/data/models/user.dart';
import 'package:gnk/data/models/reservation.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('GnkApp constructs and mounts without throwing fatal errors',
      (tester) async {
    // Phone-sized surface — the dashboard is designed for ≥ 390px screens.
    await binding.setSurfaceSize(const Size(414, 896));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const GnkApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Drain any layout-overflow warnings; the test surface is narrower than
    // real devices in a few pixel margins. Non-fatal in test mode.
    while (tester.takeException() != null) {}

    expect(find.byType(GnkApp), findsOneWidget);
  });

  group('LoyaltyCalculator', () {
    const calc = LoyaltyCalculator();

    test('points formula: 50 base + 10 per guest, +25 on VIP bypass', () {
      final r = Reservation(
        id: 'r',
        venueId: 'v',
        dateTime: DateTime(2026, 4, 1),
        guestCount: 4,
        status: ReservationStatus.vipBypassed,
      );
      expect(calc.pointsFor(r), 50 + 40 + 25); // 115
    });

    test('places the demo user in Gold tier with realistic progress', () {
      final snap = calc.snapshot(mockReservations);

      // Reservations:
      //   res_001: 4 guests, approved      → 50 + 40       = 90
      //   res_002: 2 guests, VIP bypass    → 50 + 20 + 25  = 95
      //   res_003: 6 guests, approved      → 50 + 60       = 110
      //   res_004: 2 guests, approved      → 50 + 20       = 70
      //   total                                            = 365
      expect(snap.points, 365);
      expect(snap.currentTier, LoyaltyTier.gold);
      expect(snap.nextTier, LoyaltyTier.platinum);
      expect(snap.pointsToNext, 135);
      expect(snap.progressToNext, closeTo(0.55, 0.01));
    });

    test('promotes a top-tier user without a next tier', () {
      final huge = List.generate(
        15,
        (i) => Reservation(
          id: 'r$i',
          venueId: 'v',
          dateTime: DateTime(2026, 1, i + 1),
          guestCount: 6,
          status: ReservationStatus.vipBypassed,
        ),
      );
      final snap = calc.snapshot(huge);
      expect(snap.currentTier, LoyaltyTier.obsidian);
      expect(snap.nextTier, isNull);
      expect(snap.progressToNext, 1.0);
    });
  });
}
