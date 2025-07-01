import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_up_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> signUp(SignUpParams params);
  Future<Either<Failure, AuthUser>> signIn(SignInParams params);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, Stream<AuthUser?>>> getAuthUser();
}
