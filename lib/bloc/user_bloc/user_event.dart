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

class CreateUserEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginUserEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LogOutUserEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
