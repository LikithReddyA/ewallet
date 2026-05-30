import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/params/login_params.dart';
import 'package:ewallet/features/auth/domain/params/register_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> login(LoginParams loginParams);
  Future<Either<Failure, AuthUser>> register(RegisterParams registerParams);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, AuthUser>> getCurrentUser();
}
