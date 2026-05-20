import 'package:equatable/equatable.dart';

/// Recommendation slot for the "Plus-Plus" experience — a curated thing to do
/// before or after a reservation (e.g. tailor visit, late-night ramen counter).
class VenueRecommendation extends Equatable {
  const VenueRecommendation({
    required this.title,
    required this.subtitle,
    required this.detail,
    this.icon,
  });

  final String title;
  final String subtitle;
  final String detail;

  /// Material icon code-point name (resolved at render time).
  final String? icon;

  @override
  List<Object?> get props => [title, subtitle, detail, icon];
}

class Venue extends Equatable {
  const Venue({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.history,
    required this.preEventRecommendations,
    required this.postEventRecommendations,
    required this.virtualTourUrl,
    required this.gallerySeeds,
    required this.gradient,
    required this.neighbourhood,
    required this.signatureDish,
  });

  final String id;
  final String name;

  /// Short, evocative one-liner used on cards.
  final String tagline;

  final String description;

  /// Longer-form storytelling for the "++" detail page.
  final String history;

  final List<VenueRecommendation> preEventRecommendations;
  final List<VenueRecommendation> postEventRecommendations;

  /// Placeholder URL — Tier 2 will swap this for a real 360° tour.
  final String virtualTourUrl;

  /// Deterministic seeds for the gradient image placeholders.
  final List<String> gallerySeeds;

  /// 2-color gradient stops used as the card backdrop.
  final List<int> gradient;

  final String neighbourhood;
  final String signatureDish;

  /// Display name with the Plus-Plus suffix (Maze → Maze++).
  String get plusPlusName => '$name++';

  @override
  List<Object?> get props => [
        id,
        name,
        tagline,
        description,
        history,
        preEventRecommendations,
        postEventRecommendations,
        virtualTourUrl,
        gallerySeeds,
        gradient,
        neighbourhood,
        signatureDish,
      ];
}
