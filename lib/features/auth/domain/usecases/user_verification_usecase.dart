import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class UserVerificationUsecase implements Usecase<void, NoParams> {
  final AuthRepository authRepository;

  UserVerificationUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.sendVerificationEmail();
  }
}
