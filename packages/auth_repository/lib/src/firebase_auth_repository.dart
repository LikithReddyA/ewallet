import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'auth_repo.dart';
import '../src/exceptions/exceptions.dart';

class FirebaseAuthRepository implements AuthRepo {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  Stream<firebase_auth.User?> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) => firebaseUser);

  @override
  Future<String> signUp(String email, String password) async {
    try {
      firebase_auth.UserCredential user = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return user.user!.uid;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailPasswordFailure(e.code);
    } catch (_) {
      throw SignUpWithEmailPasswordFailure();
    }
  }

  @override
  Future<String> logIn(String email, String password) async {
    try {
      firebase_auth.UserCredential user = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return user.user!.uid;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailPasswordFailure(e.code);
    } catch (_) {
      throw LogInWithEmailPasswordFailure();
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
