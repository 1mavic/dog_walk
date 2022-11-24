import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/login_screen/bloc/login_screen_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// user login/sign in screen
class LoginScreen extends StatelessWidget {
  /// user login/sign in screen
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenBlocState>(
      listener: (context, state) {
        if (state is LoginFinishedState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: (val) => context.read<LoginScreenBloc>().add(
                              ChangeFieldDataEvent(
                                email: val,
                              ),
                            ),
                        autocorrect: false,
                        maxLength: 25,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: state.emailError,
                          hintText: S.of(context).email,
                        ),
                      ),
                      TextFormField(
                        onChanged: (val) => context.read<LoginScreenBloc>().add(
                              ChangeFieldDataEvent(
                                password: val,
                              ),
                            ),
                        autocorrect: false,
                        maxLength: 15,
                        obscureText: !state.showPassword,
                        decoration: InputDecoration(
                          errorText: state.passwordError,
                          hintText: S.of(context).password,
                          alignLabelWithHint: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<LoginScreenBloc>().add(
                                    ShowPasswordEvent(),
                                  );
                            },
                            icon: state.showPassword
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: state.loading
                            ? null
                            : () {
                                if (state.loginMode) {
                                  context.read<LoginScreenBloc>().add(
                                        LoginEvent(),
                                      );
                                } else {
                                  context.read<LoginScreenBloc>().add(
                                        SingInEvent(),
                                      );
                                }
                              },
                        child: Text(
                          state.loginMode
                              ? S.of(context).login
                              : S.of(context).signIn,
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: state.loading
                              ? null
                              : () {
                                  context.read<LoginScreenBloc>().add(
                                        ChangeModeEvent(),
                                      );
                                },
                          child: Text(
                            state.loginMode
                                ? S.of(context).signIn
                                : S.of(context).login,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: state.loading
                              ? null
                              : () {
                                  context.read<LoginScreenBloc>().add(
                                        RestorePasswordevent(),
                                      );
                                },
                          child: Text(
                            S.of(context).passwordRestore,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
