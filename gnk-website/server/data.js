// In-memory store. Restaurants are seed data; reservations grow as the
// client posts. A real deployment would swap this for Postgres + a session
// table, but for a prototype it keeps the server boring.

export const RESTAURANTS = [
  {
    id: 'stanley',
    name: 'Stanley',
    tag: 'Mediterranean · Cairo',
    location: 'Sheikh Zayed',
    deposit: 250,
    rating: 4.8,
    capacityTonight: 14,
    hours: '6–11 PM',
    photo: '/photos/stanley.jpg',
    blurb: 'A modern Mediterranean table set in Sheikh Zayed.',
    history:
      'Stanley opened in 2022 as a love letter to the eastern Mediterranean coastline — Levant, Cyprus, Andalusia. Chef Maged plates with restraint; the room is lit by a single iron chandelier and 28 candles.',
  },
  {
    id: 'sax',
    name: 'Sax',
    tag: 'Cocktail & Supper',
    location: 'Zamalek',
    deposit: 300,
    rating: 4.7,
    capacityTonight: 8,
    hours: '8 PM – 2 AM',
    photo: '/photos/sax.jpg',
    blurb: 'Late-night supper club with a cocktail program for the city.',
    history:
      'The supper-club concept the city had been missing. Sax opens late, closes later. Smoke-glass mirrors, brass railings, the largest mezcal list in Egypt.',
  },
  {
    id: 'byganz',
    name: 'byGanz',
    tag: 'Chef’s Table',
    location: 'New Cairo',
    deposit: 500,
    rating: 4.9,
    capacityTonight: 6,
    hours: 'Seatings 7 & 9:30 PM',
    photo: '/photos/byganz.jpg',
    blurb: 'Founder-led chef’s table and catering atelier.',
    history:
      'Chef Ganz runs the only restaurant on the menu — twelve seats, one nine-course tasting that changes weekly. No substitutions, no walk-ins, no photos at the pass.',
  },
  {
    id: 'kikis',
    name: "KIKI's Beach",
    tag: 'Beach Club · Sahel',
    location: 'Sidi Heneish',
    deposit: 400,
    rating: 4.6,
    capacityTonight: 22,
    hours: '11 AM – dusk',
    photo: '/photos/kikis.jpg',
    blurb: 'Flagship beach club — day to dusk on Sahel.',
    history:
      'KIKI’s is where the season starts. Cabanas, a 60-metre pool, a wood-fired grill on the sand, and the only fully-licensed beach bar between Marina and Marsa Matrouh.',
  },
  {
    id: 'buoy',
    name: 'Buoy',
    tag: 'Beach Bar · Sahel',
    location: 'Sidi Heneish',
    deposit: 200,
    rating: 4.5,
    capacityTonight: 18,
    hours: '4 PM – 1 AM',
    photo: '/photos/buoy.jpg',
    blurb: 'Sister bar to KIKI’s.',
    history:
      'A driftwood-clad annex 80 metres up the cove from KIKI’s. Smaller, louder, with a turntable behind the bar and a permanent residency on Saturdays.',
  },
  {
    id: 'mazeej',
    name: 'Mazeej',
    tag: 'Hotel Kitchen · Soma',
    location: 'Soma Bay',
    deposit: 300,
    rating: 4.6,
    capacityTonight: 12,
    hours: '7 – 11 PM',
    photo: '/photos/mazeej.jpg',
    blurb: 'Hotel signature kitchen, Red Sea.',
    history:
      'The signature room at the Sheraton Soma Bay. Egyptian provincial cooking through a hotel-fine-dining lens — fattah from Aswan, kishk from Sinai, fish from the harbour 40 metres below.',
  },
];

/// Mutable list — the POST endpoint appends to this in dev mode.
export const RESERVATIONS = [
  {
    id: 'r-2025-001',
    restaurantId: 'stanley',
    dateISO: '2025-11-14T20:30:00',
    guestCount: 4,
    occasion: 'Anniversary',
    dietary: ['Pescatarian'],
    note: 'Quiet corner, cake at the end',
    status: 'confirmed',
    code: 'GNK-A4F92K',
    createdAt: new Date().toISOString(),
  },
  {
    id: 'r-2025-002',
    restaurantId: 'kikis',
    dateISO: '2025-11-22T14:00:00',
    guestCount: 6,
    occasion: 'Just because',
    dietary: [],
    note: 'Cabana for 6',
    status: 'confirmed',
    code: 'GNK-K7H21P',
    createdAt: new Date().toISOString(),
  },
  {
    id: 'r-2025-003',
    restaurantId: 'sax',
    dateISO: '2025-11-06T22:00:00',
    guestCount: 2,
    occasion: 'Date night',
    dietary: [],
    note: '',
    status: 'past',
    code: 'GNK-X3M40D',
    createdAt: new Date().toISOString(),
  },
];

let _seq = RESERVATIONS.length;
export function nextReservationId() {
  _seq += 1;
  return `r-2025-${String(_seq).padStart(3, '0')}`;
}

export function newConfirmationCode() {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  let s = '';
  for (let i = 0; i < 6; i++) s += chars[Math.floor(Math.random() * chars.length)];
  return `GNK-${s}`;
}
