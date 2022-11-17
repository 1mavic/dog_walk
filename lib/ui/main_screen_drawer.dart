import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/main.dart';
import 'package:doggie_walker/ui/user_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text('User Login'),
                ),
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
                      shape: BoxShape.circle),
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
            top: 100,
            left: 0,
            right: 0,
            child: UserAvatarWidget(),
          ),
          Positioned(
              top: 250,
              child: Column(
                children: [
                  Text(S.of(context).hello),
                  Text(
                    S.of(context).pageHomeWelcomeFullName(
                          'Aleksey',
                          'Matsegora',
                        ),
                  ),
                  Text('text 3'),
                  Text('text 4'),
                  Text('text 5'),
                ],
              ))
        ],
      ),
    );
  }
}
