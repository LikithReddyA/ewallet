import 'package:ewallet/features/auth/data/datasources/auth_datasource.dart';
import 'package:ewallet/features/auth/data/models/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDatasource({required this.firebaseAuth});
  @override
  Future<AuthUserModel> signIn(String emailId, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailId,
        password: password,
      );
      if (userCredential.user != null) {
        return AuthUserModel.fromFirebase(userCredential.user!);
      } else {
        throw FirebaseAuthException(code: "null-user");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<AuthUserModel?> getAuthUser() {
    try {
      return firebaseAuth.authStateChanges().map((firebaseUser) {
        if (firebaseUser != null) {
          return AuthUserModel.fromFirebase(firebaseUser);
        }
        return null;
      });
    } catch (e) {
      rethrow;
    }
  }
}
