part of 'login_screen_bloc_bloc.dart';

/// state of user login screen bloc
class LoginScreenBlocState extends Equatable {
  /// state of user login screen bloc
  const LoginScreenBlocState({
    this.email,
    this.emailError,
    this.password,
    this.passwordError,
    this.loading = false,
    this.showPassword = false,
    required this.loginMode,
  });

  /// current email value
  final String? email;

  /// current email error value
  final String? emailError;

  /// current password value
  final String? password;

  /// current password error value
  final String? passwordError;

  /// login mode state. if true than user is logging in.
  /// if false user is signing in
  final bool loginMode;

  /// if loading currently hapenning
  final bool loading;

  /// show/hide password characters in password field
  final bool showPassword;

  ///copyWith method
  LoginScreenBlocState copyWith({
    String? email,
    Wrapped<String?>? emailError,
    String? password,
    Wrapped<String?>? passwordError,
    bool? loginMode,
    bool? loading,
    bool? showPassword,
  }) {
    return LoginScreenBlocState(
      email: email ?? this.email,
      emailError: emailError != null ? emailError.value : this.emailError,
      password: password ?? this.password,
      passwordError:
          passwordError != null ? passwordError.value : this.passwordError,
      loginMode: loginMode ?? this.loginMode,
      loading: loading ?? this.loading,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        loginMode,
        loading,
        showPassword,
      ];
}

/// login state when process finished successfully
class LoginFinishedState extends LoginScreenBlocState {
  /// login state when process finished successfully
  const LoginFinishedState({
    super.loginMode = false,
  });
}
