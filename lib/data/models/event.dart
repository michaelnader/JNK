import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.startsAt,
    required this.venueId,
    required this.tags,
    required this.capacityRemaining,
  });

  final String id;
  final String title;
  final String subtitle;
  final DateTime startsAt;
  final String venueId;
  final Set<String> tags;
  final int capacityRemaining;

  bool get isExclusive => capacityRemaining <= 12;

  @override
  List<Object?> get props =>
      [id, title, subtitle, startsAt, venueId, tags, capacityRemaining];
}
