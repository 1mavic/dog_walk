import 'dart:async';
import 'package:doggie_walker/entity/models/user_model.dart/logged_user.dart';
import 'package:doggie_walker/entity/models/user_model.dart/user_model.dart';
import 'package:doggie_walker/entity/repositories/user_repository/user_repository_contract.dart';

/// user repository implementation
class UserRepositoryImpl implements UserRepository {
  /// user repository implementation
  final StreamController<AppUser> _userStream = StreamController<AppUser>();
  @override
  Future<void> changeUser(LoggedUser user) {
    // TODO: implement changeUser
    throw UnimplementedError();
  }

  @override
  Future<void> getUser() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    _userStream.sink.add(_mockUser);
    return;
  }

  @override
  Stream<AppUser> get userStream => _userStream.stream;

  @override
  void dispose() {
    _userStream.close();
  }
}

const _mockUser = LoggedUser(
  id: 123,
  name: 'Test User',
  pets: [],
);
