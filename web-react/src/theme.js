// G'nK App v8 — Off Duty palette
// Warm cream scenes with denim & charcoal cards. First light-scene variant.

export const T5 = {
  bgGrey: '#E6DED2',
  bgDeep: '#F5F1EA',
  scene: 'linear-gradient(180deg, #F5F1EA 0%, #E6DED2 100%)',

  cardDark: '#0E0E0E',
  cardDark2: '#2B2B2B',
  cardLight: '#F5F1EA',
  cardLight2: '#E6DED2',
  cardMid: '#6F8597',

  // accent (kept the "gold*" names from v5; now denim-toned)
  gold: '#6F8597',
  goldLight: '#A1B5C2',
  goldDeep: '#2F3E4A',
  goldSoft: 'rgba(111,133,151,0.15)',

  chrome: '#C9C9C7',
  red: '#6F8597',

  textDark: '#0E0E0E',
  textWhite: '#FFFFFF',
  textMuteL: 'rgba(14,14,14,0.55)',
  textMuteD: 'rgba(255,255,255,0.62)',
  textFaintL: 'rgba(14,14,14,0.35)',
  textFaintD: 'rgba(255,255,255,0.38)',

  divL: 'rgba(14,14,14,0.10)',
  divD: 'rgba(255,255,255,0.10)',
};

export const FONT5 =
  '"Plus Jakarta Sans", -apple-system, "SF Pro Display", system-ui, sans-serif';

// Monochrome treatment for restaurant photography.
export const MONO_FILTER = 'grayscale(100%) contrast(1.06) brightness(0.94)';
export const MONO_TINT = 'rgba(47, 62, 74, 0.18)';

// Restaurant photos — paths under /public.
export const PHOTOS = {
  stanley: '/photos/stanley.jpg',
  sax: '/photos/sax.jpg',
  byganz: '/photos/byganz.jpg',
  kikis: '/photos/kikis.jpg',
  buoy: '/photos/buoy.jpg',
  mazeej: '/photos/mazeej.jpg',
};

export const RESTAURANTS = [
  {
    id: 'stanley',
    name: 'Stanley',
    tag: 'Mediterranean · Cairo',
    deposit: 250,
    photo: PHOTOS.stanley,
    blurb: 'A modern Mediterranean table set in Sheikh Zayed.',
  },
  {
    id: 'sax',
    name: 'Sax',
    tag: 'Cocktail & Supper',
    deposit: 300,
    photo: PHOTOS.sax,
    blurb: 'Late-night supper club with a cocktail program for the city.',
  },
  {
    id: 'byganz',
    name: 'byGanz',
    tag: 'Chef’s Table',
    deposit: 500,
    photo: PHOTOS.byganz,
    blurb: 'Founder-led chef’s table and catering atelier.',
  },
  {
    id: 'kikis',
    name: "KIKI's Beach",
    tag: 'Beach Club · Sahel',
    deposit: 400,
    photo: PHOTOS.kikis,
    blurb: 'Flagship beach club — day to dusk on Sahel.',
  },
  {
    id: 'buoy',
    name: 'Buoy',
    tag: 'Beach Bar · Sahel',
    deposit: 200,
    photo: PHOTOS.buoy,
    blurb: 'Sister bar to KIKI’s.',
  },
  {
    id: 'mazeej',
    name: 'Mazeej',
    tag: 'Hotel Kitchen · Soma',
    deposit: 300,
    photo: PHOTOS.mazeej,
    blurb: 'Hotel signature kitchen, Red Sea.',
  },
];
