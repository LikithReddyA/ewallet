import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/params/register_params.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase implements UseCase<AuthUser, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});
  @override
  Future<Either<Failure, AuthUser>> call(RegisterParams params) {
    return authRepository.register(params);
  }
}
