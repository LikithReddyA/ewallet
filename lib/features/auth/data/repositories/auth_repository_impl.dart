import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/data/datasources/auth_datasource.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_up_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<Either<Failure, AuthUser>> signUp(SignUpParams params) async {
    try {
      final model = await authDatasource.signUp(
        params.emailId,
        params.password,
      );
      return Right(model.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.code));
    } catch (e) {
      return Left(
        ServerFailure(serverFailureMessage: "User couldn't be created!"),
      );
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signIn(SignInParams params) async {
    try {
      final usermodel = await authDatasource.signIn(
        params.emailId,
        params.password,
      );
      return Right(usermodel.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(firebaseFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authDatasource.signOut();
      // ignore: void_checks
      return Right(unit);
    } catch (e) {
      return Left(
        ServerFailure(
          serverFailureMessage: "Sign out failed for unkown reason",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Stream<AuthUser?>>> getAuthUser() async {
    try {
      return Right(
        authDatasource.getAuthUser().map((model) {
          return model?.toEntity();
        }),
      );
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: "Something went wrong!"));
    }
  }

  @override
  Future<Either<Failure, void>> sendVerificationEmail() async {
    try {
      await authDatasource.sendVerificationEmail();
      // ignore: void_checks
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(firebaseFailureMessage: e.code));
    } catch (e) {
      return Left(
        ServerFailure(serverFailureMessage: "Couldn't send verification email"),
      );
    }
  }

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser() async {
    try {
      final model = await authDatasource.getCurrentUser();
      return Right(model.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(firebaseFailureMessage: e.code));
    } catch (e) {
      return Left(
        ServerFailure(serverFailureMessage: "Couldn't get current user!"),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUserId() async {
    try {
      final userId = await authDatasource.getCurrentUserId();
      return Right(userId);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure(firebaseFailureMessage: e.code));
    } catch (e) {
      return Left(
        ServerFailure(serverFailureMessage: "Couldn't get current user!"),
      );
    }
  }
}
