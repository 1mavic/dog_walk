import 'package:doggie_walker/bloc/user_bloc/user_bloc.dart';
import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/login_screen/login_screen.dart';
import 'package:doggie_walker/ui/user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// drawer on main screen widget
class DrawerWidget extends StatelessWidget {
  /// drawer on main screen widget
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Drawer(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 250,
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: SizedBox(
                    width: double.infinity,
                    child: state is LoggedState
                        ? Center(
                            child: Text(
                              S.of(context).pageHomeWelcomeFullName(
                                    state.user.name,
                                  ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              const Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: UserAvatarWidget(),
              ),
              Positioned(
                top: 250,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    if (state is LoggedState && state.user.pets.isNotEmpty)
                      Text(
                        state.user.pets.first.age.toString(),
                      ),
                    const Text('text 4'),
                    const Text('text 5'),
                  ],
                ),
              ),
              if (state is LoggedState)
                Positioned(
                  top: 30,
                  right: 16,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<UserBloc>().add(
                                const LogOutUserEvent(),
                              );
                        },
                        icon: const Icon(Icons.logout),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<UserBloc>().add(
                                const DeleteUserEvent(),
                              );
                        },
                        icon: const Icon(Icons.person_off_outlined),
                      ),
                    ],
                  ),
                ),
              if (state is NotloggedState)
                Positioned(
                  top: 30,
                  right: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.login),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
