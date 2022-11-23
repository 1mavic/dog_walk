part of 'user_bloc.dart';

/// user event abstract class
abstract class UserEvent extends Equatable {
  /// user event abstract class
  const UserEvent();
}

/// user event when user changed
class UserChangedEvent extends UserEvent {
  /// user event when user changed
  const UserChangedEvent(this.newUser);

  /// new user data
  final AppUser newUser;
  @override
  List<Object?> get props => [
        newUser,
      ];
}

/// login event for login bloc with new state
class UserStateEvent extends UserEvent {
  /// login event for login bloc with new state
  const UserStateEvent(
    this.newStatus,
  );

  /// new login status from login repository
  final UserLoggingStatus newStatus;

  @override
  List<Object> get props => [
        newStatus,
      ];
}

/// create new user event
class CreateUserEvent extends UserEvent {
  /// create new user event
  const CreateUserEvent({
    required this.email,
    required this.password,
  });

  /// new user email
  final String email;

  /// new user password
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

/// login user event
class LoginUserEvent extends UserEvent {
  /// login user event
  const LoginUserEvent({
    required this.email,
    required this.password,
  });

  ///  user email
  final String email;

  ///  user password
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

/// user logout event
class LogOutUserEvent extends UserEvent {
  /// user logout event
  const LogOutUserEvent();
  @override
  List<Object?> get props => [];
}
