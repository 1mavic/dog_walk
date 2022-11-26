import 'dart:async';

import 'package:doggie_walker/entity/models/errors/login_error.dart';
import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';

class TestRepository extends LoginRepository {
  final _latency = Future.delayed(const Duration(seconds: 1));
  final StreamController<UserLoggingStatus> _statusStream =
      StreamController<UserLoggingStatus>.broadcast();

  final StreamController<LoginError?> _errorStream =
      StreamController<LoginError?>.broadcast();
  @override
  Future<void> checkState() async {
    await _latency;
    // TODO: implement checkState
    throw UnimplementedError();
  }

  @override
  Future<void> createUser(String email, String password) async {
    await _latency;
    await _latency;
    _statusStream.add(UserLoggingStatus.logged);
  }

  @override
  void dispose() {
    _statusStream.close();
    _errorStream.close();
  }

  @override
  Stream<LoginError?> get errorStatus => _errorStream.stream;

  @override
  Future<void> logOutUser() async {
    await _latency;
    _statusStream.add(UserLoggingStatus.notLogged);
  }

  @override
  Stream<UserLoggingStatus> get loginStatus => _statusStream.stream;

  @override
  Future<void> loginUser(String email, String password) async {
    await _latency;
    _statusStream.add(UserLoggingStatus.logged);
  }

  @override
  Future<void> restoreUserPassword(String email) async {
    await _latency;
    _errorStream.add(LoginError(error: ''));
  }
}
