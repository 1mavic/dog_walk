part of 'login_screen_bloc_bloc.dart';

/// login screen event class
abstract class LoginScreenBlocEvent extends Equatable {
  /// login screen event class
  const LoginScreenBlocEvent();

  @override
  List<Object> get props => [];
}

/// log in user event
class LoginEvent extends LoginScreenBlocEvent {}

/// sign in user event
class SingInEvent extends LoginScreenBlocEvent {}

/// restore user event
class RestorePasswordevent extends LoginScreenBlocEvent {}

/// change mode from log to sign and vise versa
class ChangeModeEvent extends LoginScreenBlocEvent {}

/// show/hide password field
class ShowPasswordEvent extends LoginScreenBlocEvent {}

/// show error event
class ShowErrorEvent extends LoginScreenBlocEvent {
  /// show error event
  const ShowErrorEvent(this.loginError);

  /// object with error texts
  final LoginError? loginError;
}

/// change text of email or password event
class ChangeFieldDataEvent extends LoginScreenBlocEvent {
  /// change text of email or password event
  const ChangeFieldDataEvent({
    this.email,
    this.password,
  });

  /// new email value
  final String? email;

  /// new password value
  final String? password;
}

/// login/ signIn completed successfully
class FinishedEvent extends LoginScreenBlocEvent {}
