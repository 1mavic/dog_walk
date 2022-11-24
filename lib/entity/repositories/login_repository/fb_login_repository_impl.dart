import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// login user service with farebase implementation
class FirebaseLoginRepository implements LoginRepository {
  /// login user service with farebase implementation
  FirebaseLoginRepository() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('not logged');
        _statusStream.sink.add(
          UserLoggingStatus.notLogged,
        );
      } else {
        log('logged');
        _statusStream.sink.add(
          UserLoggingStatus.logged,
        );
      }
    });
  }
  final StreamController<UserLoggingStatus> _statusStream =
      StreamController<UserLoggingStatus>.broadcast();

  @override
  void dispose() => _statusStream.close();

  @override
  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Stream<UserLoggingStatus> get loginStatus => _statusStream.stream;

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> checkState() async {}

  @override
  Future<void> createUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').add(
        {
          'userId': credential.user?.uid,
          'name': 'Aleksei',
          'pets': <String>[],
        },
      );
      log(credential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    log('created');
  }
}
