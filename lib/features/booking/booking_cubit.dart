import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/booking_form.dart';

/// Tiny cubit that lives at the booking-flow route shell. Holds the working
/// [BookingForm] across the four step pages.
class BookingCubit extends Cubit<BookingForm> {
  BookingCubit(String restaurantId)
      : super(BookingForm(restaurantId: restaurantId));

  void setParty(int n) => emit(state.copyWith(guestCount: n));
  void setDate(DateTime d) => emit(state.copyWith(date: d));
  void setTime(String t) => emit(state.copyWith(time: t));
  void setOccasion(String? o) => emit(state.copyWith(occasion: o));
  void setNote(String s) => emit(state.copyWith(note: s));
  void setDietary(Set<String> d) => emit(state.copyWith(dietary: d));

  /// Reset the form for a freshly-started booking at [restaurantId].
  void reset(String restaurantId) =>
      emit(BookingForm(restaurantId: restaurantId));
}
