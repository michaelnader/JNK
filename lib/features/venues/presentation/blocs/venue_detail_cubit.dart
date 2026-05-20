import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/venue.dart';
import '../../../../domain/repositories/venue_repository.dart';

abstract class VenueDetailState extends Equatable {
  const VenueDetailState();
  @override
  List<Object?> get props => [];
}

class VenueDetailLoading extends VenueDetailState {
  const VenueDetailLoading();
}

class VenueDetailLoaded extends VenueDetailState {
  const VenueDetailLoaded(this.venue);
  final Venue venue;
  @override
  List<Object?> get props => [venue];
}

class VenueDetailNotFound extends VenueDetailState {
  const VenueDetailNotFound(this.id);
  final String id;
  @override
  List<Object?> get props => [id];
}

class VenueDetailCubit extends Cubit<VenueDetailState> {
  VenueDetailCubit({required this.repository}) : super(const VenueDetailLoading());

  final VenueRepository repository;

  void load(String venueId) {
    final v = repository.findById(venueId);
    if (v == null) {
      emit(VenueDetailNotFound(venueId));
    } else {
      emit(VenueDetailLoaded(v));
    }
  }
}
