import '../../data/mock/mock_events.dart';
import '../../data/models/event.dart';

abstract interface class EventRepository {
  List<Event> getAll();

  /// Returns events whose [Event.tags] overlap with the supplied user
  /// interests, ranked by overlap count (most relevant first).
  List<Event> matchedFor(Set<String> userInterests);
}

class InMemoryEventRepository implements EventRepository {
  const InMemoryEventRepository();

  @override
  List<Event> getAll() => List.unmodifiable(mockEvents);

  @override
  List<Event> matchedFor(Set<String> userInterests) {
    final scored = mockEvents
        .map((e) => (event: e, score: e.tags.intersection(userInterests).length))
        .where((entry) => entry.score > 0)
        .toList()
      ..sort((a, b) {
        final byScore = b.score.compareTo(a.score);
        if (byScore != 0) return byScore;
        return a.event.startsAt.compareTo(b.event.startsAt);
      });
    return scored.map((e) => e.event).toList(growable: false);
  }
}
