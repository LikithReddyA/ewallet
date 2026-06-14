import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/errors/failure_handler.dart';
import 'package:ewallet/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/params/login_params.dart';
import 'package:ewallet/features/auth/domain/params/register_params.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, AuthUser>> login(LoginParams loginParams) async {
    try {
      final user = await authRemoteDataSource.login(
        email: loginParams.email,
        password: loginParams.password,
      );
      return Right(user.toEntity());
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> register(
    RegisterParams registerParams,
  ) async {
    try {
      final user = await authRemoteDataSource.register(
        email: registerParams.email,
        password: registerParams.password,
      );
      return Right(user.toEntity());
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authRemoteDataSource.logout();
      return Right(unit);
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUser();
      return Right(user.toEntity());
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> refreshUser() async {
    try {
      final user = await authRemoteDataSource.refreshUser();
      return Right(user.toEntity());
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendVerificationEmail() async {
    try {
      await authRemoteDataSource.sendVerificationEmail();
      return Right(unit);
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCurrentUser() async {
    try {
      await authRemoteDataSource.deleteCurrentUser();
      return Right(unit);
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }
}
