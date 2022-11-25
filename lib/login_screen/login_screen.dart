import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';
import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/login_screen/bloc/login_screen_bloc_bloc.dart';
import 'package:doggie_walker/login_screen/ui/bezier_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// user login/sign in screen
class LoginScreen extends StatelessWidget {
  /// user login/sign in screen
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding.top;
    return BlocProvider(
      create: (context) => LoginScreenBloc(
        context.read<LoginRepository>(),
      ),
      child: Builder(
        builder: (context) {
          return BlocConsumer<LoginScreenBloc, LoginScreenBlocState>(
            listener: (context, state) {
              if (state is LoginFinishedState) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              final hasError =
                  state.emailError != null || state.passwordError != null;
              return Scaffold(
                body: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BezierContainerWidget(
                            color: Theme.of(context).primaryColor,
                            height: 150 + kToolbarHeight + padding,
                          ),
                          const Spacer(),
                          const _TextInputWidget(),
                          const SizedBox(
                            height: 15,
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: ElevatedButton(
                              onPressed: state.loading || hasError
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
                          ),
                          Center(
                            child: TextButton(
                              onPressed: state.loading || hasError
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
                              onPressed: state.loading || hasError
                                  ? null
                                  : () {
                                      context.read<LoginScreenBloc>().add(
                                            RestorePasswordEvent(),
                                          );
                                    },
                              child: Text(
                                S.of(context).passwordRestore,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TextInputWidget extends StatefulWidget {
  const _TextInputWidget();

  @override
  State<_TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<_TextInputWidget> {
  final focusNode = FocusNode();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginScreenBloc, LoginScreenBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            children: [
              TextFormField(
                enabled: !state.loading,
                onChanged: (val) => context.read<LoginScreenBloc>().add(
                      ChangeFieldDataEvent(
                        email: val,
                      ),
                    ),
                onFieldSubmitted: (_) {
                  focusNode.requestFocus();
                },
                textInputAction: TextInputAction.next,
                autocorrect: false,
                maxLength: 25,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: state.emailError,
                  errorMaxLines: 2,
                  hintText: S.of(context).email,
                  counterText: '',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: focusNode,
                enabled: !state.loading,
                onChanged: (val) => context.read<LoginScreenBloc>().add(
                      ChangeFieldDataEvent(
                        password: val,
                      ),
                    ),
                onFieldSubmitted: (_) {
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
                textInputAction: TextInputAction.done,
                autocorrect: false,
                maxLength: 15,
                obscureText: !state.showPassword,
                decoration: InputDecoration(
                  errorText: state.passwordError,
                  errorMaxLines: 2,
                  hintText: S.of(context).password,
                  alignLabelWithHint: true,
                  suffixIconConstraints: const BoxConstraints(maxHeight: 38),
                  counterText: '',
                  isDense: true,
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
        );
      },
    );
  }
}
