import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggie_walker/entity/models/user_model.dart/logged_user.dart';
import 'package:doggie_walker/entity/models/user_model.dart/user_model.dart';
import 'package:doggie_walker/entity/repositories/user_repository/user_repository_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// user repository implementation
class UserRepositoryImpl implements UserRepository {
  /// user repository implementation
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final StreamController<AppUser> _userStream = StreamController<AppUser>();
  @override
  Future<void> changeUser(LoggedUser user) {
    // TODO: implement changeUser
    throw UnimplementedError();
  }

  @override
  Future<void> getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final users = await firestore
        .collection('users')
        .where('userId', isEqualTo: user.uid)
        .get();
    if (users.docs.isEmpty) {
      log('no user in table');
      return;
    }
    final userPets = await firestore
        .collection('pets')
        .where('ownerId', isEqualTo: user.uid)
        .get();
    final loggedUser = LoggedUser.fromFs(
      users.docs.first.data(),
      userPets.docs.map((userPet) => userPet.data()).toList(),
    );
    _userStream.sink.add(loggedUser);
    return;
  }

  @override
  Stream<AppUser> get userStream => _userStream.stream;

  @override
  void dispose() {
    _userStream.close();
  }
}
