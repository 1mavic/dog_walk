import 'dart:async';
import 'dart:developer';
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
      StreamController<UserLoggingStatus>();

  @override
  void dispose() => _statusStream.close();

  @override
  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Stream<UserLoggingStatus> get loginStatus => _statusStream.stream;

  @override
  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'amacegora@gmail.com',
        password: 'password1',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {}
  }

  @override
  Future<void> checkState() async {
    final user = await FirebaseAuth.instance.currentUser;
  }

  @override
  Future<void> createUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'amacegora@gmail.com',
        password: 'password',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    log('created');
  }
}
