import 'dart:async';

import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/models/user_model.dart/user.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

/// user logged status bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// user logged status bloc
  LoginBloc(
    this._loginRepository,
  ) : super(LoginInitial()) {
    _loginStateSub = _loginRepository.loginStatus.listen((newStatus) {
      add(LoginEvent(newStatus));
    });
    on<LoginEvent>((event, emit) async {
      final status = event.newStatus;
      if (status == UserLoggingStatus.notLogged) {
        emit(
          NotloggedState(),
        );
        return;
      }
      if (status == UserLoggingStatus.logged) {
        emit(
          LoggedState(
            await _getUserData(),
          ),
        );
        return;
      }
    });
  }
  final LoginRepository _loginRepository;
  late StreamSubscription<UserLoggingStatus> _loginStateSub;

  Future<LoggedUser> _getUserData() async {
    return LoggedUser(
      id: _mockUser.id,
      name: _mockUser.name,
    );
  }

  @override
  Future<void> close() {
    _loginStateSub.cancel();
    _loginRepository.dispose();
    return super.close();
  }
}

const _mockUser = LoggedUser(
  id: 123,
  name: 'Test User',
);
