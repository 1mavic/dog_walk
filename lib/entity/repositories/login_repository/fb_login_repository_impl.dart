import 'dart:async';
import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';

/// login user service with farebase implementation
class FirebaseLoginRepository implements LoginRepository {
  final StreamController<UserLoggingStatus> _userStream =
      StreamController<UserLoggingStatus>.broadcast();

  @override
  void dispose() => _userStream.close();

  @override
  Future<void> logOutUser() async {
    _userStream.sink.add(
      UserLoggingStatus.notLogged,
    );
  }

  @override
  Stream<UserLoggingStatus> get loginStatus => _userStream.stream;

  @override
  Future<void> loginUser() async {
    _userStream.sink.add(
      UserLoggingStatus.logged,
    );
  }
}
