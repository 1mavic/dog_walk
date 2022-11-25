import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggie_walker/entity/models/errors/login_error.dart';
import 'package:doggie_walker/entity/models/login/login_state.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository_contract.dart';
import 'package:doggie_walker/generated/l10n.dart';
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

  final StreamController<LoginError?> _errorStream =
      StreamController<LoginError?>.broadcast();

  @override
  void dispose() {
    _statusStream.close();
    _errorStream.close();
  }

  @override
  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Stream<UserLoggingStatus> get loginStatus => _statusStream.stream;

  @override
  Stream<LoginError?> get errorStatus => _errorStream.stream;

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('mail')) {
        _errorStream.add(
          LoginError(
            emailError: e.message,
          ),
        );
      } else if (e.code.contains('password')) {
        _errorStream.add(
          LoginError(
            passwordError: e.message,
          ),
        );
      } else {
        _errorStream.add(
          LoginError(
            error: e.message,
          ),
        );
      }
    } catch (e) {
      _errorStream.add(
        LoginError(
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> restoreUserPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      _errorStream.add(
        LoginError(
          error: S.current.resetMessageSend,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('mail')) {
        _errorStream.add(
          LoginError(
            emailError: e.message,
          ),
        );
      } else if (e.code.contains('password')) {
        _errorStream.add(
          LoginError(
            passwordError: e.message,
          ),
        );
      } else {
        _errorStream.add(
          LoginError(
            error: e.message,
          ),
        );
      }
    } catch (e) {
      _errorStream.add(
        LoginError(
          error: e.toString(),
        ),
      );
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
      if (e.code.contains('mail')) {
        _errorStream.add(
          LoginError(
            emailError: e.message,
          ),
        );
      } else if (e.code.contains('password')) {
        _errorStream.add(
          LoginError(
            passwordError: e.message,
          ),
        );
      } else {
        _errorStream.add(
          LoginError(
            error: e.message,
          ),
        );
      }
    } catch (e) {
      _errorStream.add(
        LoginError(
          error: e.toString(),
        ),
      );
    }
  }
}
