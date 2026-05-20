import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/loyalty_calculator.dart';
import '../../../../data/models/reservation.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/repositories/reservation_repository.dart';
import '../../../../domain/repositories/user_repository.dart';

class LoyaltyState extends Equatable {
  const LoyaltyState({
    required this.loading,
    this.user,
    this.snapshot,
    this.history = const [],
  });

  const LoyaltyState.loading() : this(loading: true);

  final bool loading;
  final User? user;
  final LoyaltySnapshot? snapshot;
  final List<Reservation> history;

  @override
  List<Object?> get props => [loading, user, snapshot, history];
}

class LoyaltyCubit extends Cubit<LoyaltyState> {
  LoyaltyCubit({
    required UserRepository userRepository,
    required ReservationRepository reservationRepository,
    LoyaltyCalculator calculator = const LoyaltyCalculator(),
  })  : _userRepo = userRepository,
        _repo = reservationRepository,
        _calc = calculator,
        super(const LoyaltyState.loading()) {
    _sub = _repo.watchAll().listen(_handle);
  }

  final UserRepository _userRepo;
  final ReservationRepository _repo;
  final LoyaltyCalculator _calc;
  StreamSubscription<List<Reservation>>? _sub;

  void _handle(List<Reservation> reservations) {
    final sorted = List<Reservation>.of(reservations)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
    emit(
      LoyaltyState(
        loading: false,
        user: _userRepo.current(),
        snapshot: _calc.snapshot(reservations),
        history: sorted,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
