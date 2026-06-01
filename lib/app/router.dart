import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/account/my_reservations_page.dart';
import '../features/booking/booking_cubit.dart';
import '../features/booking/date_picker_page.dart';
import '../features/booking/occasion_page.dart';
import '../features/booking/review_page.dart';
import '../features/booking/time_slots_page.dart';
import '../features/home/home_page.dart';
import '../features/payment/add_card_page.dart';
import '../features/payment/confirmation_page.dart';
import '../features/payment/payment_page.dart';
import '../features/restaurants/restaurant_detail_page.dart';
import '../features/restaurants/restaurants_page.dart';

final _rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter buildRouter() {
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomePage()),
      GoRoute(
        path: '/restaurants',
        builder: (_, __) => const RestaurantsPage(),
      ),
      GoRoute(
        path: '/restaurants/:id',
        builder: (_, s) => RestaurantDetailPage(id: s.pathParameters['id']!),
        routes: [
          // /restaurants/:id/book — start of the wizard. Reset the cubit for
          // this restaurant then jump to step 1.
          GoRoute(
            path: 'book',
            redirect: (context, state) {
              final id = state.pathParameters['id']!;
              context.read<BookingCubit>().reset(id);
              return '/booking/date';
            },
          ),
        ],
      ),

      // Booking wizard
      GoRoute(
        path: '/booking/date',
        builder: (_, __) => const DatePickerPage(),
      ),
      GoRoute(
        path: '/booking/time',
        builder: (_, __) => const TimeSlotsPage(),
      ),
      GoRoute(
        path: '/booking/occasion',
        builder: (_, __) => const OccasionPage(),
      ),
      GoRoute(
        path: '/booking/review',
        builder: (_, __) => const ReviewPage(),
      ),

      // Payment + confirmation
      GoRoute(path: '/payment', builder: (_, __) => const PaymentPage()),
      GoRoute(path: '/payment/add', builder: (_, __) => const AddCardPage()),
      GoRoute(
        path: '/confirmation',
        builder: (_, __) => const ConfirmationPage(),
      ),

      // Account
      GoRoute(
        path: '/reservations',
        builder: (_, __) => const MyReservationsPage(),
      ),
    ],
  );
}
