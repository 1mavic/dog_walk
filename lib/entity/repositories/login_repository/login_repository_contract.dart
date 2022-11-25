import 'dart:async';
import 'package:doggie_walker/entity/models/errors/login_error.dart';
import 'package:doggie_walker/entity/models/login/login_state.dart';

/// login user service
abstract class LoginRepository {
  /// login user service
  const LoginRepository();

  /// get user stream.
  /// return logged or not logged user
  Stream<UserLoggingStatus> get loginStatus;

  /// get error login stream.
  /// return object with error or null
  Stream<LoginError?> get errorStatus;

  /// log in user method
  Future<void> loginUser(
    String email,
    String password,
  );

  /// restore user password method
  Future<void> restoreUserPassword(
    String email,
  );

  /// log out user method
  Future<void> logOutUser();

  /// check user login state method
  Future<void> checkState();

  /// create user
  Future<void> createUser(
    String email,
    String password,
  );

  /// dispose repository
  void dispose();
}
