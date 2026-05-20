import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// User-facing JNK Privilege Club view vs admin/VIP Tali concierge surface.
enum AppMode { user, admin }

class AppModeState extends Equatable {
  const AppModeState({
    required this.mode,
    this.tier2Unlocked = false,
  });

  final AppMode mode;

  /// Until Tier 2 ships fully, switching to admin sends the user to the
  /// "coming soon" stub. When true the router will start exposing live
  /// admin routes.
  final bool tier2Unlocked;

  AppModeState copyWith({AppMode? mode, bool? tier2Unlocked}) => AppModeState(
        mode: mode ?? this.mode,
        tier2Unlocked: tier2Unlocked ?? this.tier2Unlocked,
      );

  @override
  List<Object?> get props => [mode, tier2Unlocked];
}

class AppModeCubit extends Cubit<AppModeState> {
  AppModeCubit()
      : super(const AppModeState(mode: AppMode.user, tier2Unlocked: false));

  void enterUserMode() => emit(state.copyWith(mode: AppMode.user));
  void enterAdminMode() => emit(state.copyWith(mode: AppMode.admin));
  void toggle() => emit(
        state.copyWith(
          mode: state.mode == AppMode.user ? AppMode.admin : AppMode.user,
        ),
      );

  /// Wires Tier 2 once Tali ships. Today it just enables admin routes.
  void unlockTier2() => emit(state.copyWith(tier2Unlocked: true));
}
