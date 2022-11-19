part of 'login_bloc.dart';

/// login event for login bloc
class LoginEvent extends Equatable {
  /// login event for login bloc
  const LoginEvent(
    this.newStatus,
  );

  /// new login status from login repository
  final UserLoggingStatus newStatus;

  @override
  List<Object> get props => [];
}

// /// log in user event
// class LogInUserEvent extends LoginEvent {
//   /// log in user event
//   const LogInUserEvent();
// }

// /// log out user event
// class LogOutUserEvent extends LoginEvent {
//   /// log out user event
//   const LogOutUserEvent();
// }
