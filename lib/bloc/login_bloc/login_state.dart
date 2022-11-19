part of 'login_bloc.dart';

/// state of login use bloc
abstract class LoginState extends Equatable {
  /// state of login use bloc
  const LoginState();

  @override
  List<Object> get props => [];
}

/// initial state for login bloc
class LoginInitial extends LoginState {}

/// user not logged state
class NotloggedState extends LoginState {
  /// user field
  final user = const NotLoggedUser();
}

/// user logged in state
class LoggedState extends LoginState {
  /// user logged in state
  const LoggedState(this.user);

  /// user field
  final LoggedUser user;
}
