# JNK Privilege Club — Tier 1 prototype

Premium loyalty + booking hub for the JNK / Tali ecosystem. This first build
ships **Tier 1 only** (the user-facing club). **Tier 2 (Tali concierge)** is
wired as a stub route, kept architecturally seamful so it can be filled in
later without restructuring.

Built on Flutter 3.44 / Dart 3.12. Targets iOS, Android, web, Windows, macOS,
Linux out of the box.

---

## Visual language

A premium "chic dark mode" with glassmorphism throughout:

- **Canvas** — deep obsidian (`#0A0A0A` → `#161821`) with slowly drifting
  radial blobs in muted gold and midnight blue (`AmbientBackground`).
- **Glass surfaces** — translucent white fill at ~8% opacity, hairline border
  at ~15%, blurred backdrop (`ImageFilter.blur(σ=10)`), soft layered shadow.
  Composed via `GlassContainer` and surfaced through six reusable widgets.
- **Typography** — Cormorant Garamond for hero/display text and Inter for
  every UI line; pulled at runtime via `google_fonts` (configurable to bundle
  later — see `lib/main.dart`).
- **Accents** — champagne gold `#D4AF37` for primary actions and tier badges,
  midnight `#0F172A` for cooler surfaces, platinum `#EFEFEF` for headlines.

All tokens live in `lib/app/constants.dart` (`AppColors`, `AppGlass`,
`AppSpacing`, `AppRadii`, `AppDurations`).

---

## State management

`flutter_bloc` throughout. Choice of `Bloc` vs `Cubit` per feature:

| Feature | Type | Why |
|---|---|---|
| **AppMode** | Cubit | Two-state toggle, no event semantics |
| **Dashboard** | Cubit | Subscribes to reservation stream + computes loyalty snapshot |
| **Loyalty** | Cubit | Same reservation stream; derives tier + history |
| **Invites** | Cubit | Filters + ranks events by interest-tag overlap |
| **VenueDetail** | Cubit | Single-method `load(id)` |
| **Booking** | **Bloc** | Multi-step form with distinct user intents — events make state transitions explicit and testable |

Global blocs are wired into `lib/app/app.dart` via `MultiBlocProvider`.
Repositories are exposed through `MultiRepositoryProvider` so the same
in-memory instance flows everywhere (book a reservation in Booking → see it
instantly in Loyalty + Dashboard via the broadcast stream).

---

## Routing

`go_router 16.x` with a `StatefulShellRoute.indexedStack` for the 4-tab base
(Dashboard, Venues, Loyalty, Invites). Venue detail, booking, booking-success,
and the Tier 2 stub are top-level routes that escape the shell.

The router has a `refreshListenable` adapter (`_CubitListenable`) bound to
`AppModeCubit.stream`, so flipping into Admin mode redirects to `/tier2`
without any imperative navigation.

```
/                     → redirects to /dashboard
/dashboard            (shell tab 0)
/venues               (shell tab 1)
/venues/:id           (full-screen detail)
/venues/:id/book      (full-screen booking)
/loyalty              (shell tab 2)
/invites              (shell tab 3)
/booking-success      (full-screen confirmation; takes Reservation as extra)
/tier2                (Tali stub — admin mode gate)
```

---

## Folder layout (feature-first + clean per-feature)

```
lib/
├── main.dart                     # entrypoint
├── app/
│   ├── app.dart                  # GnkApp — Multi(Repository|Bloc)Provider + MaterialApp.router
│   ├── router.dart               # GoRouter with ShellRoute and admin redirect
│   ├── theme.dart                # ThemeData + google_fonts text theme
│   └── constants.dart            # AppColors, AppGlass, AppSpacing, AppRadii
├── core/
│   ├── extensions/context_x.dart # context.colorScheme/textTheme shortcuts
│   └── utils/
│       ├── loyalty_calculator.dart  # pure: List<Reservation> → LoyaltySnapshot
│       └── date_formatter.dart       # intl-backed formatters (full / relative / etc)
├── data/
│   ├── models/  (user, venue, reservation, event, booking_form)
│   └── mock/    (mock_user, mock_venues, mock_events, mock_reservations)
├── domain/
│   └── repositories/
│       ├── user_repository.dart
│       ├── venue_repository.dart
│       ├── reservation_repository.dart  # exposes broadcast Stream<List<Reservation>>
│       └── event_repository.dart        # ranks by interest-tag overlap
├── features/
│   ├── app_mode/                 # global User/Admin cubit
│   ├── dashboard/                # cubit + page + VenueCarousel + LoyaltySummaryStrip
│   ├── venues/                   # list + detail (Plus-Plus story header, recommendations)
│   ├── booking/                  # Bloc with events + date-time sheet + guest stepper + summary
│   ├── loyalty/                  # tier progress arc + reservation history
│   ├── invites/                  # interest-tag filtered event feed
│   └── tier2_stub/               # Tali "coming soon" placeholder
└── shared/
    └── widgets/
        ├── glass/                # GlassContainer, GlassCard, GlassButton, GlassModal, GlassChip, GlassNavBar, AmbientBackground
        └── common/               # AppShell, SectionHeader, GradientImagePlaceholder
```

---

## Glass widget catalogue

All glass widgets resolve their colors from `AppColors` + `AppGlass`.

| Widget | Purpose |
|---|---|
| `GlassContainer` | Low-level. The canonical recipe: `ClipRRect → BackdropFilter → DecoratedBox` |
| `GlassCard` | Tappable content surface; animated press scale |
| `GlassButton` | `primary` / `gold` / `ghost` variants, loading + leading/trailing icons |
| `GlassModal.show(…)` | Frosted bottom sheet with drag handle and optional title |
| `GlassChip` | Pill for tags, filters, status badges (selectable) |
| `GlassNavBar` | Floating bottom nav for the shell |
| `AmbientBackground` | Full-screen obsidian canvas + drifting radial light blobs |

Standard recipe in `GlassContainer`:

```dart
ClipRRect(
  borderRadius: ...,
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        gradient: <subtle top highlight>,
      ),
      child: ...,
    ),
  ),
)
```

---

## Mock data

- **3 venues** (`mockVenues`) — Maze, Samara, Kiki's — each with a distinct
  story, pre- and post-event recommendation pairs, neighbourhood, and gradient.
- **5 upcoming events** (`mockEvents`) — June–July 2026 calendar, tagged with
  interests so the Invites feed ranks them by overlap with `mockUser.interestTags`.
- **1 demo user** (`mockUser`) — Alaa El Ama, member since 2024-09. Interest
  tags: `music`, `whisky`, `gastronomy`, `art`.
- **4 prior reservations** (`mockReservations`) — Jan/Feb/Mar/Apr 2026, spread
  across all three venues.

**Loyalty math** (`loyalty_calculator.dart`):

- Points per reservation: `50 + (guestCount × 10) + (VIP_Bypassed ? 25 : 0)`
- Tiers: Silver 0–199, Gold 200–499, Platinum 500–999, Obsidian 1000+
- Demo user lands in **Gold** with 365 pts (135 to Platinum)

Booking a new reservation flows through the broadcast
`ReservationRepository.watchAll()` stream and updates Dashboard + Loyalty in
real time — book a party of 6+ to see VIP bypass status flow through.

---

## Running

### Prerequisites

- Flutter 3.44+ (Dart 3.12+). Get from <https://flutter.dev>.
- For platform targets:
  - **iOS** — Xcode 15+, an iOS simulator or device
  - **Android** — Android Studio + an emulator or device
  - **Web** — any modern browser (`chrome` or `edge` work today)
  - **Windows desktop** — enable Developer Mode (Settings → Privacy & Security
    → For Developers) so plugin symlinks resolve, plus Visual Studio 2022
    with the "Desktop development with C++" workload
  - **macOS / Linux desktop** — Xcode + macOS, or a Linux toolchain

### Commands

```bash
# Install deps
flutter pub get

# Static analysis (passes clean)
flutter analyze

# Tests (loyalty math + structural smoke test)
flutter test

# Run on default device
flutter run

# Run on a specific device
flutter run -d chrome
flutter run -d edge
flutter run -d windows
flutter run -d <iOS simulator id>
flutter run -d <android emulator id>
```

The first launch downloads Inter + Cormorant Garamond via `google_fonts`
(needs network). To go fully offline, set
`GoogleFonts.config.allowRuntimeFetching = false` in `lib/main.dart` and
bundle the two font families under `assets/fonts/`.

---

## What's intentionally left out

| Area | State today | When you fill it in |
|---|---|---|
| **Tier 2 — Tali concierge** | Single stub page at `/tier2` | Wire the VIP reservation manager, virtual tour viewports, and the AI itinerary chat. The `ReservationStatus.vipBypassed` flag and `AppModeCubit.admin` mode are already in place |
| **AI Itinerary repository** | Not present yet | Add `domain/repositories/itinerary_repository.dart` with `Stream<String> streamItinerary({required prompt})` and a `FakeItineraryRepository` that emits a hand-tuned itinerary token-by-token via `Stream.fromIterable` + `Future.delayed` |
| **Auth / persistence** | None — in-memory mock user, no SharedPreferences | When real auth lands, replace `InMemoryUserRepository` with a network-backed impl. The cubits don't need to change |
| **Network images** | Gradient placeholders (`GradientImagePlaceholder`) | Swap for `Image.network` or `cached_network_image` once real image URLs exist; gradients per venue are kept stable via FNV-1a hash of the seed |
| **Push notifications for invites** | Local list only | Hook your push provider into `InvitesCubit.load()` when events arrive |

---

## Performance notes

- `BackdropFilter` is expensive — each glass surface is a full-screen
  offscreen pass. The dashboard caps visible glass at ~3 large surfaces, and
  the venue carousel wraps each card in a `RepaintBoundary` to avoid
  cascading repaints during horizontal scroll. Profile in `--profile` mode
  before tuning `AppGlass.blurSigma`.
- `AmbientBackground` is animated with a single `AnimationController` driving
  a `CustomPainter`. Costs are bounded to the canvas size — turn it off via
  `AmbientBackground(animated: false)` on heavier screens if needed.
- The `ReservationRepository` stream is broadcast — multiple cubit listeners
  share the same source. Each cubit cancels its subscription in `close()`.

---

## License

Internal prototype. No license assigned.
