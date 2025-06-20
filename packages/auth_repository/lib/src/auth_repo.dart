import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Stream<User?> get user;

  User? getCurrentUser();

  Future<String> signUp(String email, String password);

  Future<String> logIn(String email, String password);

  Future<void> logOut();
}
