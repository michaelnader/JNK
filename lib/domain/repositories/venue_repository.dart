import '../../data/mock/mock_venues.dart';
import '../../data/models/venue.dart';

/// Read-only access to the curated venue list.
abstract interface class VenueRepository {
  List<Venue> getAll();
  Venue? findById(String id);
}

class InMemoryVenueRepository implements VenueRepository {
  const InMemoryVenueRepository();

  @override
  List<Venue> getAll() => mockVenues;

  @override
  Venue? findById(String id) {
    for (final v in mockVenues) {
      if (v.id == id) return v;
    }
    return null;
  }
}
