import '../models/user.dart';

/// Demo user driving the prototype. Their interest tags determine which events
/// surface in the Invites feed.
final mockUser = User(
  id: 'usr_001',
  firstName: 'Alaa',
  lastName: 'El Ama',
  email: 'alaa@elama.ai',
  memberSince: DateTime(2024, 9, 12),
  interestTags: const {
    'music',
    'whisky',
    'gastronomy',
    'art',
  },
);
