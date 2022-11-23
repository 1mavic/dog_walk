import 'dart:async';
import 'package:doggie_walker/entity/models/login/login_state.dart';

/// login user service
abstract class LoginRepository {
  /// login user service
  const LoginRepository();

  /// get user stream.
  /// return logged or not logged user
  Stream<UserLoggingStatus> get loginStatus;

  /// log in user method
  Future<void> loginUser(
    String email,
    String password,
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
