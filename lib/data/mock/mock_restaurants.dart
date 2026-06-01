import '../models/restaurant.dart';

/// The six G'nK group restaurants — Egypt.
const List<Restaurant> mockRestaurants = [
  Restaurant(
    id: 'stanley',
    name: 'Stanley',
    tag: 'Mediterranean · Cairo',
    deposit: 250,
    blurb: 'A modern Mediterranean table set in Sheikh Zayed.',
    photoAsset: 'assets/photos/stanley.jpg',
  ),
  Restaurant(
    id: 'sax',
    name: 'Sax',
    tag: 'Cocktail & Supper',
    deposit: 300,
    blurb: 'Late-night supper club with a cocktail program for the city.',
    photoAsset: 'assets/photos/sax.jpg',
  ),
  Restaurant(
    id: 'byganz',
    name: 'byGanz',
    tag: 'Chef’s Table',
    deposit: 500,
    blurb: 'Founder-led chef’s table and catering atelier.',
    photoAsset: 'assets/photos/byganz.jpg',
  ),
  Restaurant(
    id: 'kikis',
    name: "KIKI's Beach",
    tag: 'Beach Club · Sahel',
    deposit: 400,
    blurb: 'Flagship beach club — day to dusk on Sahel.',
    photoAsset: 'assets/photos/kikis.jpg',
  ),
  Restaurant(
    id: 'buoy',
    name: 'Buoy',
    tag: 'Beach Bar · Sahel',
    deposit: 200,
    blurb: 'Sister bar to KIKI’s.',
    photoAsset: 'assets/photos/buoy.jpg',
  ),
  Restaurant(
    id: 'mazeej',
    name: 'Mazeej',
    tag: 'Hotel Kitchen · Soma',
    deposit: 300,
    blurb: 'Hotel signature kitchen, Red Sea.',
    photoAsset: 'assets/photos/mazeej.jpg',
  ),
];

Restaurant restaurantById(String id) =>
    mockRestaurants.firstWhere((r) => r.id == id);
