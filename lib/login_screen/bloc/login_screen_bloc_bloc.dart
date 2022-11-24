import 'dart:async';
import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';
import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/utils/wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_bloc_event.dart';
part 'login_screen_bloc_state.dart';

/// login screen view bloc
class LoginScreenBloc extends Bloc<LoginScreenBlocEvent, LoginScreenBlocState> {
  /// login screen view bloc
  LoginScreenBloc(
    this._loginRepository,
  ) : super(
          const LoginScreenBlocState(
            loginMode: true,
          ),
        ) {
    _loginSub = _loginRepository.loginStatus.listen((event) {
      if (event == UserLoggingStatus.logged) {
        add(FinishedEvent());
      }
    });
    on<ChangeFieldDataEvent>(_onFieldChange);
    on<ChangeModeEvent>(_changeMode);
    on<FinishedEvent>(_finish);
    on<LoginEvent>(_login);
    on<SingInEvent>(_signIn);
    on<ShowPasswordEvent>(_showPassword);
  }
  final LoginRepository _loginRepository;
  late StreamSubscription<UserLoggingStatus> _loginSub;

  void _changeMode(
    ChangeModeEvent event,
    Emitter<LoginScreenBlocState> emit,
  ) {
    emit(
      state.copyWith(
        loginMode: !state.loginMode,
      ),
    );
  }

  void _showPassword(
    ShowPasswordEvent event,
    Emitter<LoginScreenBlocState> emit,
  ) {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
      ),
    );
  }

  void _onFieldChange(
    ChangeFieldDataEvent event,
    Emitter<LoginScreenBlocState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        emailError: event.email != null
            ? const Wrapped.value(null)
            : Wrapped.value(state.emailError),
        password: event.password,
        passwordError: event.password != null
            ? const Wrapped.value(null)
            : Wrapped.value(state.passwordError),
      ),
    );
  }

  void _login(
    LoginEvent event,
    Emitter<LoginScreenBlocState> emit,
  ) {
    final isFieldsValid = _validateFields(emit);
    if (!isFieldsValid) {
      return;
    }
    _loginRepository.loginUser(
      state.email ?? '',
      state.password ?? '',
    );
  }

  void _signIn(
    SingInEvent event,
    Emitter<LoginScreenBlocState> emit,
  ) {
    final isFieldsValid = _validateFields(emit);
    if (!isFieldsValid) {
      return;
    }
    _loginRepository.createUser(
      state.email ?? '',
      state.password ?? '',
    );
  }

  void _finish(
    FinishedEvent event,
    Emitter<LoginScreenBlocState> emit,
  ) {
    emit(
      const LoginFinishedState(),
    );
  }

  @override
  Future<void> close() {
    _loginSub.cancel();
    return super.close();
  }

  bool _validateFields(Emitter<LoginScreenBlocState> emit) {
    final email = state.email;
    final password = state.password;
    String? emailError;
    String? passwordError;
    if (email == null) {
      emailError = S.current.emptyField;
    } else if (email.trim().isEmpty) {
      emailError = S.current.emptyField;
    } else {
      final format = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(email.trim());
      if (!format) {
        emailError = S.current.invalidEmail;
      }
    }
    if (password == null) {
      passwordError = S.current.emptyField;
    } else if (password.trim().isEmpty) {
      passwordError = S.current.emptyField;
    } else if (password.length < 6) {
      passwordError = S.current.shortPassword;
    }
    if (emailError != null && passwordError != null) {
      emit(
        state.copyWith(
          emailError: Wrapped.value(emailError),
          passwordError: Wrapped.value(passwordError),
        ),
      );
      return false;
    }
    return true;
  }
}
