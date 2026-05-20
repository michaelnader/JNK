import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/app.dart';
import 'app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Premium dark surfaces edge-to-edge.
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlay);

  // Permit on-demand font fetching for the prototype. To ship offline, set
  // this to false and bundle Inter + Cormorant Garamond via the assets dir.
  GoogleFonts.config.allowRuntimeFetching = true;

  runApp(const GnkApp());
}
