import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> signIn(SignInParams params);
  Future<Either<Failure, void>> signOut();
}
