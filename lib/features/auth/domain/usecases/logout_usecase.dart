import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase implements UseCase<Unit, NoParams> {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return authRepository.logout();
  }
}
