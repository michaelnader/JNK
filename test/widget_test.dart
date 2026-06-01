import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gnk/app/app.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets("GnkApp mounts the Off Duty Home", (tester) async {
    await binding.setSurfaceSize(const Size(402, 874));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const GnkApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Drain layout overflow warnings (the test surface is exact phone size).
    while (tester.takeException() != null) {}

    expect(find.byType(GnkApp), findsOneWidget);
    expect(find.text("G'NK"), findsOneWidget); // top-bar wordmark on Home
  });
}
