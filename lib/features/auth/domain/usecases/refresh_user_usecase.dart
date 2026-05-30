import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class RefreshUserUsecase extends UseCase<AuthUser, NoParams> {
  final AuthRepository _authRepository;

  RefreshUserUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;
  @override
  Future<Either<Failure, AuthUser>> call(NoParams params) async {
    return await _authRepository.refreshUser();
  }
}
