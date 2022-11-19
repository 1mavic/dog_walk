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
  final User newUser;
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
