part of 'user_bloc.dart';

/// state of login use bloc
abstract class UserState extends Equatable {
  /// state of login use bloc
  const UserState();

  @override
  List<Object> get props => [];
}

/// initial state for login bloc
class UserInitial extends UserState {}

/// user not logged state
class NotloggedState extends UserState {
  /// user field
  final user = const NotLoggedUser();
}

/// user logged in state
class LoggedState extends UserState {
  /// user logged in state
  const LoggedState(this.user);

  /// user field
  final LoggedUser user;
}
