import 'package:ewallet/core/errors/exceptions.dart';
import 'package:ewallet/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ewallet/features/auth/data/mappers/auth_user_mapper.dart';
import 'package:ewallet/features/auth/data/models/auth_user_model.dart';
import 'package:ewallet/core/errors/firebase_exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});
  @override
  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final user = credential.user;
      if (user == null) {
        throw AuthException("User not found");
      }
      return user.toModel();
    } on FirebaseAuthException catch (e) {
      throw AuthException(mapFirebaseAuthError(e));
    } catch (e) {
      throw ServerException("Something went wrong, please try again");
    }
  }

  @override
  Future<AuthUserModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw AuthException("User not found!");
      }
      return user.toModel();
    } on FirebaseAuthException catch (e) {
      throw AuthException(mapFirebaseAuthError(e));
    } catch (e) {
      throw ServerException("Something went wrong, please try again");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(mapFirebaseAuthError(e));
    } catch (e) {
      throw ServerException("Something went wrong, please try again");
    }
  }

  @override
  Future<AuthUserModel> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw AuthException("User not found!");
      }
      return user.toModel();
    } on FirebaseAuthException catch (e) {
      throw AuthException(mapFirebaseAuthError(e));
    } catch (e) {
      throw ServerException("Something went wrong, please try again");
    }
  }
}
