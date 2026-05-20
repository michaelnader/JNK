import '../../data/mock/mock_user.dart';
import '../../data/models/user.dart';

abstract interface class UserRepository {
  User current();
}

class InMemoryUserRepository implements UserRepository {
  const InMemoryUserRepository();

  @override
  User current() => mockUser;
}
