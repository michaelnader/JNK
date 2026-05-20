import 'package:equatable/equatable.dart';

/// Discrete loyalty tiers; thresholds live in [loyalty_calculator.dart].
enum LoyaltyTier {
  silver(label: 'Silver', minPoints: 0),
  gold(label: 'Gold', minPoints: 200),
  platinum(label: 'Platinum', minPoints: 500),
  obsidian(label: 'Obsidian', minPoints: 1000);

  const LoyaltyTier({required this.label, required this.minPoints});

  final String label;
  final int minPoints;
}

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.memberSince,
    required this.interestTags,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime memberSince;
  final Set<String> interestTags;

  String get fullName => '$firstName $lastName';

  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
          .toUpperCase();

  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, memberSince, interestTags];
}
