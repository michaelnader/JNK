import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/models/reservation.dart';
import '../features/app_mode/bloc/app_mode_cubit.dart';
import '../features/booking/presentation/pages/booking_page.dart';
import '../features/booking/presentation/pages/booking_success_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/invites/presentation/pages/invites_page.dart';
import '../features/loyalty/presentation/pages/loyalty_page.dart';
import '../features/tier2_stub/presentation/pages/tier2_stub_page.dart';
import '../features/venues/presentation/pages/venue_detail_page.dart';
import '../features/venues/presentation/pages/venues_list_page.dart';
import '../shared/widgets/common/app_shell.dart';

final _rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Builds the go_router tree. The [appModeCubit] feeds [refreshListenable] so
/// redirects re-run when the user switches between JNK (Tier 1) and Tali
/// (Tier 2) modes.
GoRouter buildRouter(AppModeCubit appModeCubit) {
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: '/dashboard',
    refreshListenable: _CubitListenable(appModeCubit),
    redirect: (context, state) {
      final mode = appModeCubit.state.mode;
      final goingToTier2 = state.matchedLocation.startsWith('/tier2');
      if (mode == AppMode.admin && !goingToTier2) {
        return '/tier2';
      }
      if (mode == AppMode.user && goingToTier2) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/venues',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: VenuesListPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/loyalty',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: LoyaltyPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/invites',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: InvitesPage(),
                ),
              ),
            ],
          ),
        ],
      ),
      // Full-screen routes (escape the shell)
      GoRoute(
        path: '/venues/:id',
        parentNavigatorKey: _rootNavKey,
        builder: (context, state) =>
            VenueDetailPage(venueId: state.pathParameters['id']!),
        routes: [
          GoRoute(
            path: 'book',
            parentNavigatorKey: _rootNavKey,
            builder: (context, state) =>
                BookingPage(venueId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: '/booking-success',
        parentNavigatorKey: _rootNavKey,
        builder: (context, state) {
          final reservation = state.extra as Reservation?;
          if (reservation == null) {
            // Defensive — should never happen via UI navigation.
            return const _MissingExtraScaffold();
          }
          return BookingSuccessPage(reservation: reservation);
        },
      ),
      GoRoute(
        path: '/tier2',
        parentNavigatorKey: _rootNavKey,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Tier2StubPage(),
        ),
      ),
    ],
  );
}

/// Adapts a Bloc/Cubit's stream into the [Listenable] go_router expects.
class _CubitListenable extends ChangeNotifier {
  _CubitListenable(BlocBase<Object?> cubit) {
    notifyListeners();
    _sub = cubit.stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription<Object?> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

class _MissingExtraScaffold extends StatelessWidget {
  const _MissingExtraScaffold();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Missing reservation context.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
