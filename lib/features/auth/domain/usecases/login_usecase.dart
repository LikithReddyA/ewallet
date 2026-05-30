import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/params/login_params.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthUser, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  @override
  Future<Either<Failure, AuthUser>> call(LoginParams params) {
    return authRepository.login(params);
  }
}
