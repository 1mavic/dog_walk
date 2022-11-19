import 'package:doggie_walker/bloc/user_bloc/user_bloc.dart';
import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/ui/user_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
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
                  decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
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
              Positioned(
                top: 10,
                right: 16,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
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
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    Text('text 3'),
                    Text('text 4'),
                    Text('text 5'),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
