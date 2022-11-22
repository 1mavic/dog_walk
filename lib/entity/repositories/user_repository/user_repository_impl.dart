import 'dart:async';
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
    final users = firestore.collection('users').doc(user.uid);
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    _userStream.sink.add(_mockUser);
    return;
  }

  @override
  Stream<AppUser> get userStream => _userStream.stream;

  @override
  void dispose() {
    _userStream.close();
  }
}

const _mockUser = LoggedUser(
  id: 123,
  name: 'Test User',
  pets: [],
);
