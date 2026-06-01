import 'package:equatable/equatable.dart';

/// One of the six G'nK group restaurants.
class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.tag,
    required this.deposit,
    required this.blurb,
    required this.photoAsset,
  });

  final String id;
  final String name;

  /// Cuisine + neighbourhood, shown under the name everywhere.
  final String tag;

  /// Refundable per-guest deposit in EGP.
  final int deposit;

  final String blurb;

  /// Path to the bundled monochrome photo (e.g. `assets/photos/stanley.jpg`).
  final String photoAsset;

  @override
  List<Object?> get props => [id, name, tag, deposit, blurb, photoAsset];
}
