import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/loyalty_calculator.dart';
import '../../../../data/models/reservation.dart';
import '../../../../data/models/user.dart';
import '../../../../data/models/venue.dart';
import '../../../../domain/repositories/reservation_repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../domain/repositories/venue_repository.dart';

class DashboardState extends Equatable {
  const DashboardState({
    required this.loading,
    this.user,
    this.featuredVenues = const [],
    this.upcomingReservation,
    this.loyalty,
  });

  const DashboardState.loading() : this(loading: true);

  final bool loading;
  final User? user;
  final List<Venue> featuredVenues;
  final Reservation? upcomingReservation;
  final LoyaltySnapshot? loyalty;

  DashboardState copyWith({
    bool? loading,
    User? user,
    List<Venue>? featuredVenues,
    Reservation? upcomingReservation,
    LoyaltySnapshot? loyalty,
  }) =>
      DashboardState(
        loading: loading ?? this.loading,
        user: user ?? this.user,
        featuredVenues: featuredVenues ?? this.featuredVenues,
        upcomingReservation: upcomingReservation ?? this.upcomingReservation,
        loyalty: loyalty ?? this.loyalty,
      );

  @override
  List<Object?> get props =>
      [loading, user, featuredVenues, upcomingReservation, loyalty];
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required UserRepository userRepository,
    required VenueRepository venueRepository,
    required ReservationRepository reservationRepository,
    LoyaltyCalculator loyaltyCalculator = const LoyaltyCalculator(),
  })  : _userRepo = userRepository,
        _venueRepo = venueRepository,
        _reservationRepo = reservationRepository,
        _calc = loyaltyCalculator,
        super(const DashboardState.loading()) {
    _subscribe();
  }

  final UserRepository _userRepo;
  final VenueRepository _venueRepo;
  final ReservationRepository _reservationRepo;
  final LoyaltyCalculator _calc;
  StreamSubscription<List<Reservation>>? _sub;

  void _subscribe() {
    _sub = _reservationRepo.watchAll().listen(_handleReservations);
  }

  void _handleReservations(List<Reservation> reservations) {
    final now = DateTime.now();
    final upcoming = reservations
        .where((r) => r.dateTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    emit(
      state.copyWith(
        loading: false,
        user: _userRepo.current(),
        featuredVenues: _venueRepo.getAll(),
        upcomingReservation: upcoming.isNotEmpty ? upcoming.first : null,
        loyalty: _calc.snapshot(reservations),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
