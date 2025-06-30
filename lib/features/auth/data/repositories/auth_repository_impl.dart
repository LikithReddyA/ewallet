import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/data/datasources/auth_datasource.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({required this.authDatasource});

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
      return Right(unit);
    } catch (e) {
      return Left(
        ServerFailure(
          serverFailureMessage: "Sign out failed for unkown reason",
        ),
      );
    }
  }
}
