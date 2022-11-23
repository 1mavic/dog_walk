import 'package:doggie_walker/entity/models/user_model.dart/user.dart';

/// user repository class
abstract class UserRepository {
  /// user repository class
  const UserRepository();

  /// user stream return User class
  Stream<AppUser> get userStream;

  /// function to get current user data
  Future<void> getUser();

  /// change current user data
  Future<void> changeUser(LoggedUser user);

  /// dispose repository
  void dispose();
}
