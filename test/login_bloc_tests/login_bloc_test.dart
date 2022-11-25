import 'package:bloc_test/bloc_test.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository.dart';
import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/login_screen/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('login bloc tests', () {
    late LoginScreenBloc loginBloc;
    final testRepository = TestRepository();
    setUp(
      () => loginBloc = LoginScreenBloc(
        testRepository,
      ),
    );

    test('initial state is in login mode', () {
      expect(loginBloc.state.loginMode, true);
    });

    blocTest<LoginScreenBloc, LoginScreenBlocState>(
      'change of login mode in state',
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(ChangeModeEvent()),
      expect: () => <LoginScreenBlocState>[
        const LoginScreenBlocState(
          loginMode: false,
        )
      ],
    );

    blocTest<LoginScreenBloc, LoginScreenBlocState>(
      'emits change of email field',
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(
        const ChangeFieldDataEvent(
          email: 'test@test.ru',
        ),
      ),
      expect: () => <LoginScreenBlocState>[
        const LoginScreenBlocState(
          email: 'test@test.ru',
          loginMode: true,
        )
      ],
    );

    blocTest<LoginScreenBloc, LoginScreenBlocState>(
      'emits change of password field',
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(
        const ChangeFieldDataEvent(
          password: 'testPassword',
        ),
      ),
      expect: () => <LoginScreenBlocState>[
        const LoginScreenBlocState(
          password: 'testPassword',
          loginMode: true,
        )
      ],
    );

    blocTest<LoginScreenBloc, LoginScreenBlocState>(
      'emits change of email and password field',
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(
        const ChangeFieldDataEvent(
          email: 'test@test.ru',
          password: 'testPassword',
        ),
      ),
      expect: () => <LoginScreenBlocState>[
        const LoginScreenBlocState(
          email: 'test@test.ru',
          password: 'testPassword',
          loginMode: true,
        )
      ],
    );

    blocTest<LoginScreenBloc, LoginScreenBlocState>(
      'show password change in state',
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(ShowPasswordEvent()),
      expect: () => <LoginScreenBlocState>[
        const LoginScreenBlocState(
          loginMode: true,
          showPassword: true,
        )
      ],
    );

    blocTest<LoginScreenBloc, LoginScreenBlocState>(
      'error field on loggin with empty email',
      build: () => loginBloc,
      seed: () => const LoginScreenBlocState(
        loginMode: true,
        password: 'password',
      ),
      act: (bloc) => loginBloc.add(LoginEvent()),
      wait: const Duration(seconds: 2),
      expect: () => <LoginScreenBlocState>[
        const LoginScreenBlocState(
          loginMode: true,
          password: 'password',
          emailError: 'поле не должно быть пустым',
        )
      ],
    );
  });
}
