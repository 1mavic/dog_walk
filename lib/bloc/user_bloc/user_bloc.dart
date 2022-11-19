import 'dart:async';

import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/models/user_model.dart/user.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository.dart';
import 'package:doggie_walker/entity/repositories/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

/// user logged status bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  /// user logged status bloc
  UserBloc(
    this._loginRepository,
    this._userRepository,
  ) : super(UserInitial()) {
    _loginStateSub = _loginRepository.loginStatus.listen((newStatus) {
      add(UserStateEvent(newStatus));
    });
    _userSub = _userRepository.userStream.listen((newUser) {
      add(UserChangedEvent(newUser));
    });
    on<UserStateEvent>(_onStateChange);
    on<UserChangedEvent>(_onUserChanged);
  }
  final LoginRepository _loginRepository;
  final UserRepository _userRepository;
  late StreamSubscription<User> _userSub;
  late StreamSubscription<UserLoggingStatus> _loginStateSub;

  Future<void> _onStateChange(
    UserStateEvent event,
    Emitter<UserState> emit,
  ) async {
    final status = event.newStatus;
    if (status == UserLoggingStatus.notLogged ||
        status == UserLoggingStatus.loginError) {
      emit(
        NotloggedState(),
      );
      return;
    }
    if (status == UserLoggingStatus.logged) {
      unawaited(_getUserData());
      return;
    }
  }

  Future<void> _onUserChanged(
    UserChangedEvent event,
    Emitter<UserState> emit,
  ) async {
    final user = event.newUser;
    if (user is NotLoggedUser) {
      emit(
        NotloggedState(),
      );
      return;
    }
    if (user is LoggedUser) {
      emit(
        LoggedState(user),
      );
      return;
    }
  }

  Future<void> _getUserData() async {
    unawaited(
      _userRepository.getUser(),
    );
  }

  @override
  Future<void> close() {
    _loginStateSub.cancel();
    _loginRepository.dispose();
    _userSub.cancel();
    _userRepository.dispose();
    return super.close();
  }
}
