import 'dart:async';
import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';

/// login user service with farebase implementation
class FirebaseLoginRepository implements LoginRepository {
  final StreamController<UserLoggingStatus> _statusStream =
      StreamController<UserLoggingStatus>();

  @override
  void dispose() => _statusStream.close();

  @override
  Future<void> logOutUser() async {
    _statusStream.sink.add(
      UserLoggingStatus.notLogged,
    );
  }

  @override
  Stream<UserLoggingStatus> get loginStatus => _statusStream.stream;

  @override
  Future<void> loginUser() async {
    _statusStream.sink.add(
      UserLoggingStatus.logged,
    );
  }
}
