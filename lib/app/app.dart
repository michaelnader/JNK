import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/loyalty_calculator.dart';
import '../domain/repositories/event_repository.dart';
import '../domain/repositories/reservation_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/repositories/venue_repository.dart';
import '../features/app_mode/bloc/app_mode_cubit.dart';
import '../features/dashboard/presentation/blocs/dashboard_cubit.dart';
import '../features/invites/presentation/blocs/invites_cubit.dart';
import '../features/loyalty/presentation/blocs/loyalty_cubit.dart';
import 'router.dart';
import 'theme.dart';

class GnkApp extends StatefulWidget {
  const GnkApp({super.key});

  @override
  State<GnkApp> createState() => _GnkAppState();
}

class _GnkAppState extends State<GnkApp> {
  late final InMemoryReservationRepository _reservationRepo;
  late final InMemoryVenueRepository _venueRepo;
  late final InMemoryEventRepository _eventRepo;
  late final InMemoryUserRepository _userRepo;
  late final AppModeCubit _appMode;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _reservationRepo = InMemoryReservationRepository();
    _venueRepo = const InMemoryVenueRepository();
    _eventRepo = const InMemoryEventRepository();
    _userRepo = const InMemoryUserRepository();
    _appMode = AppModeCubit();
    _router = buildRouter(_appMode);
  }

  @override
  void dispose() {
    _reservationRepo.dispose();
    _appMode.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: _userRepo),
        RepositoryProvider<VenueRepository>.value(value: _venueRepo),
        RepositoryProvider<ReservationRepository>.value(value: _reservationRepo),
        RepositoryProvider<EventRepository>.value(value: _eventRepo),
        RepositoryProvider<LoyaltyCalculator>.value(
          value: const LoyaltyCalculator(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppModeCubit>.value(value: _appMode),
          BlocProvider<DashboardCubit>(
            create: (ctx) => DashboardCubit(
              userRepository: ctx.read<UserRepository>(),
              venueRepository: ctx.read<VenueRepository>(),
              reservationRepository: ctx.read<ReservationRepository>(),
            ),
          ),
          BlocProvider<LoyaltyCubit>(
            create: (ctx) => LoyaltyCubit(
              userRepository: ctx.read<UserRepository>(),
              reservationRepository: ctx.read<ReservationRepository>(),
            ),
          ),
          BlocProvider<InvitesCubit>(
            create: (ctx) => InvitesCubit(
              userRepository: ctx.read<UserRepository>(),
              eventRepository: ctx.read<EventRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'JNK Privilege Club',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.build(),
          routerConfig: _router,
        ),
      ),
    );
  }
}
