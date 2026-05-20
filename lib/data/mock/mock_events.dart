import '../models/event.dart';

/// Upcoming private events. Dates anchored to 2026 so the demo timeline reads
/// "soon" relative to current date 2026-05-20.
final List<Event> mockEvents = [
  Event(
    id: 'evt_001',
    title: "Kiki's Vinyl Night — Bossa & Brown Spirits",
    subtitle: 'Closed listening set · 38 seats',
    startsAt: DateTime(2026, 6, 4, 21, 0),
    venueId: 'venue_kikis',
    tags: const {'music', 'whisky', 'nightlife'},
    capacityRemaining: 9,
  ),
  Event(
    id: 'evt_002',
    title: 'Samara Chef\'s Table — 12 Hands',
    subtitle: 'Six guest chefs, one hearth, no menu shown',
    startsAt: DateTime(2026, 6, 12, 20, 30),
    venueId: 'venue_samara',
    tags: const {'gastronomy', 'wine'},
    capacityRemaining: 14,
  ),
  Event(
    id: 'evt_003',
    title: 'Maze × Hermès Silk Launch',
    subtitle: 'Private preview · members only',
    startsAt: DateTime(2026, 6, 21, 19, 0),
    venueId: 'venue_maze',
    tags: const {'fashion', 'art'},
    capacityRemaining: 6,
  ),
  Event(
    id: 'evt_004',
    title: "Obsidian Members' Mixology Lab",
    subtitle: 'Three-bartender showcase · hosted by Layla',
    startsAt: DateTime(2026, 7, 3, 19, 30),
    venueId: 'venue_kikis',
    tags: const {'cocktails', 'whisky'},
    capacityRemaining: 12,
  ),
  Event(
    id: 'evt_005',
    title: 'Garden Cinema: Wong Kar-wai Retrospective',
    subtitle: 'Open-air screening · 2046 cuts',
    startsAt: DateTime(2026, 7, 18, 21, 30),
    venueId: 'venue_maze',
    tags: const {'cinema', 'art'},
    capacityRemaining: 22,
  ),
];
