import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/event.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/repositories/event_repository.dart';
import '../../../../domain/repositories/user_repository.dart';

class InvitesState extends Equatable {
  const InvitesState({
    required this.loading,
    this.user,
    this.matched = const [],
    this.dismissed = const {},
    this.activeFilters = const {},
  });

  const InvitesState.loading() : this(loading: true);

  final bool loading;
  final User? user;
  final List<Event> matched;
  final Set<String> dismissed;
  final Set<String> activeFilters;

  List<Event> get visible {
    final base = matched.where((e) => !dismissed.contains(e.id));
    if (activeFilters.isEmpty) return base.toList(growable: false);
    return base
        .where((e) => e.tags.intersection(activeFilters).isNotEmpty)
        .toList(growable: false);
  }

  InvitesState copyWith({
    bool? loading,
    User? user,
    List<Event>? matched,
    Set<String>? dismissed,
    Set<String>? activeFilters,
  }) =>
      InvitesState(
        loading: loading ?? this.loading,
        user: user ?? this.user,
        matched: matched ?? this.matched,
        dismissed: dismissed ?? this.dismissed,
        activeFilters: activeFilters ?? this.activeFilters,
      );

  @override
  List<Object?> get props => [loading, user, matched, dismissed, activeFilters];
}

class InvitesCubit extends Cubit<InvitesState> {
  InvitesCubit({
    required UserRepository userRepository,
    required EventRepository eventRepository,
  })  : _userRepo = userRepository,
        _eventRepo = eventRepository,
        super(const InvitesState.loading()) {
    load();
  }

  final UserRepository _userRepo;
  final EventRepository _eventRepo;

  void load() {
    final user = _userRepo.current();
    final matched = _eventRepo.matchedFor(user.interestTags);
    emit(
      state.copyWith(
        loading: false,
        user: user,
        matched: matched,
      ),
    );
  }

  void toggleFilter(String tag) {
    final next = Set<String>.of(state.activeFilters);
    if (!next.add(tag)) {
      next.remove(tag);
    }
    emit(state.copyWith(activeFilters: next));
  }

  void dismiss(String eventId) {
    final next = Set<String>.of(state.dismissed)..add(eventId);
    emit(state.copyWith(dismissed: next));
  }
}
