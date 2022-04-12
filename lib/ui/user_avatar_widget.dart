import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent,
      ),
      child: const Icon(
        CupertinoIcons.profile_circled,
        size: 75,
        color: Colors.white,
      ),
    );
  }
}
