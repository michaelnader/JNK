import '../models/venue.dart';

/// Three signature venues — each tuned with a distinct mood, story angle,
/// and Plus-Plus arc. Designed to feel like a curated members' guide rather
/// than a directory listing.
const List<Venue> mockVenues = [
  Venue(
    id: 'venue_maze',
    name: 'Maze',
    tagline: 'Hidden in the bones of a 1924 typesetters\' workshop.',
    description:
        'Neo-Mediterranean small plates, smoke-cured ceilings, ink-black '
        'banquettes. The kind of room that swallows the city outside its door.',
    history:
        'Maze opened in late 2021 inside what had been the Garamond & Sons '
        'printing house — a narrow, three-storey building tucked off the '
        'pedestrian spine of the old quarter. The original lead-type cabinets '
        'were left in place along the east wall; you eat between them. Chef '
        'Rania pulls heavily from the Levant but plates with a Catalan '
        'restraint — most dishes arrive on a single dark ceramic plate, '
        'with no garnish beyond what the fire left behind.',
    preEventRecommendations: [
      VenueRecommendation(
        title: 'Habib & Sons Tailoring',
        subtitle: '5 min walk · arrive by 7:15',
        detail:
            'Tucked beside the courtyard fountain. Walk-ins welcome for '
            'last-minute pocket squares, cuff adjustments, or a press.',
        icon: 'content_cut',
      ),
      VenueRecommendation(
        title: 'Garamond Library',
        subtitle: 'Same building · members only',
        detail:
            'The third floor reading room — original press archive, no '
            'phones above the velvet rope. A 20-minute pause before service.',
        icon: 'menu_book',
      ),
    ],
    postEventRecommendations: [
      VenueRecommendation(
        title: 'Soraya Rooftop',
        subtitle: '12 min by car · open until 2am',
        detail:
            'Nightcap with a view back over the quarter. Ask for the bench '
            'at the north balcony — Maze guests are seated immediately.',
        icon: 'nightlife',
      ),
      VenueRecommendation(
        title: 'Print Room Espresso',
        subtitle: '2 min walk · opens 6am',
        detail:
            'Morning-after ristretto cut with cardamom. They keep a list of '
            'returning Maze faces and have your usual ready.',
        icon: 'local_cafe',
      ),
    ],
    virtualTourUrl: 'tali://virtual-tour/venue_maze',
    gallerySeeds: ['maze-hearth', 'maze-banquette', 'maze-court'],
    gradient: [0xFF3A2A1A, 0xFF1A1410],
    neighbourhood: 'Old Quarter',
    signatureDish: 'Charcoal lamb shoulder, sumac onion',
  ),
  Venue(
    id: 'venue_samara',
    name: 'Samara',
    tagline: 'Twelve charcoals. One hearth. No menu before eight.',
    description:
        'A Levantine fire-kitchen run by ear. The menu is read aloud each '
        'night — handed to the bar at sunset, then to your table.',
    history:
        'Samara is the second project from the family behind the now-closed '
        'Bakr in Beirut. They moved here in 2023 with one truck, two ovens, '
        'and the entire archive of grandmother Samara\'s notes. The walls are '
        'lime-washed to absorb the smoke; the lighting is from beeswax pillars '
        'set into iron sconces. Sommelier Mouna pours from a 600-bottle list '
        'that you will never see — she will ask you three questions and choose.',
    preEventRecommendations: [
      VenueRecommendation(
        title: 'Beit Zayt',
        subtitle: '10 min walk · book 1 day ahead',
        detail:
            'Private oud-blending session: choose your three notes, the '
            'house perfumer assembles a 10ml bottle to take to dinner.',
        icon: 'spa',
      ),
      VenueRecommendation(
        title: 'Quartet Recital Room',
        subtitle: 'Concierge can release seats',
        detail:
            'A 45-minute chamber programme that ends precisely at 7:50pm. '
            'A car waits outside; you arrive at Samara at exactly 8:05.',
        icon: 'music_note',
      ),
    ],
    postEventRecommendations: [
      VenueRecommendation(
        title: 'Backgammon Hall, Rue Saadeh',
        subtitle: 'Open until 4am · all ages welcome',
        detail:
            'Order an arak. Take a table by the window. The house keeper '
            'will find you an opponent within four minutes.',
        icon: 'casino',
      ),
      VenueRecommendation(
        title: 'Late knafeh at Habibah',
        subtitle: '3 min walk · cash preferred',
        detail:
            'A second dessert. They\'ll seat Samara guests in the back room '
            'where they finish off the night\'s tray.',
        icon: 'cake',
      ),
    ],
    virtualTourUrl: 'tali://virtual-tour/venue_samara',
    gallerySeeds: ['samara-hearth', 'samara-wine', 'samara-spice'],
    gradient: [0xFF2B1B2C, 0xFF120C1A],
    neighbourhood: 'Eastern Boulevards',
    signatureDish: 'Whole grilled denise over vine leaves',
  ),
  Venue(
    id: 'venue_kikis',
    name: "Kiki's",
    tagline: 'A 4,000-record listening bar. No phones above the bar.',
    description:
        'A speakeasy listening bar — vinyl-only, low light, deep listening. '
        'You order your first drink. The bartender selects your second.',
    history:
        "Kiki's was opened in 2019 by sisters Mai and Layla Sabbagh — both "
        'former jazz programmers at the public radio. The 4,000-record wall '
        'is a real archive (their late uncle\'s collection, started in 1962); '
        'they have catalogued every sleeve. The room holds 38 people. There '
        'is no menu — the bartender\'s palate guides the second drink based on '
        'what you ordered first, and what side of the record is currently '
        'playing. Phones above the bar are politely intercepted.',
    preEventRecommendations: [
      VenueRecommendation(
        title: 'Polaroid Atelier',
        subtitle: '6 min walk · session by appointment',
        detail:
            'A vintage SX-70 portrait sitting — 8 frames, all delivered by '
            'hand. The bar will keep one of the prints behind the till if '
            'you ask.',
        icon: 'camera_alt',
      ),
      VenueRecommendation(
        title: 'Sound Check at Studio 9',
        subtitle: 'Reserved for members · Fri only',
        detail:
            'Sit in on a 30-minute soundcheck of the band closing the venue '
            'that weekend. You leave with a signed setlist.',
        icon: 'graphic_eq',
      ),
    ],
    postEventRecommendations: [
      VenueRecommendation(
        title: 'Ichigo Ramen',
        subtitle: 'Opens 1am · 8 seats',
        detail:
            'Tonkotsu, shoyu, miso. Layla will message ahead so the chef '
            'leaves your table empty as you cross the alley.',
        icon: 'ramen_dining',
      ),
      VenueRecommendation(
        title: 'Walk along the Old Pier',
        subtitle: 'Quiet at 2am · 15 min',
        detail:
            'Recommended only between Sept and May. Bring the second drink '
            'with you — bartender will lend a thermos.',
        icon: 'directions_walk',
      ),
    ],
    virtualTourUrl: 'tali://virtual-tour/venue_kikis',
    gallerySeeds: ['kikis-wall', 'kikis-turntable', 'kikis-bar'],
    gradient: [0xFF1A2640, 0xFF0C111E],
    neighbourhood: 'Harbour Lane',
    signatureDish: "The bartender's second pour",
  ),
];
