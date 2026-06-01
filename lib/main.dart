import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Permit on-demand font fetching for the prototype.
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const GnkApp());
}
