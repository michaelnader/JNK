import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/booking/booking_cubit.dart';
import 'router.dart';
import 'theme.dart';

class GnkApp extends StatefulWidget {
  const GnkApp({super.key});

  @override
  State<GnkApp> createState() => _GnkAppState();
}

class _GnkAppState extends State<GnkApp> {
  // Singleton wizard cubit — restaurant id is reset on each "Reserve" tap.
  late final BookingCubit _bookingCubit = BookingCubit('stanley');
  late final _router = buildRouter();

  @override
  void dispose() {
    _bookingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCubit>.value(
      value: _bookingCubit,
      child: MaterialApp.router(
        title: "G'nK Restaurants",
        debugShowCheckedModeBanner: false,
        theme: buildGnkTheme(),
        routerConfig: _router,
      ),
    );
  }
}
