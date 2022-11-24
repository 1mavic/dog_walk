import 'package:equatable/equatable.dart';

/// login error class
class LoginError extends Equatable {
  /// login error class
  const LoginError({
    this.emailError,
    this.passwordError,
    this.error,
  });

  /// email error text
  final String? emailError;

  /// password error text
  final String? passwordError;

  /// error text
  final String? error;

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
        error,
      ];
}
