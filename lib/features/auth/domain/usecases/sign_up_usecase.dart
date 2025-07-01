import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_up_params.dart';

class SignUpUsecase implements Usecase<AuthUser, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUsecase({required this.authRepository});
  @override
  Future<Either<Failure, AuthUser>> call(SignUpParams params) async {
    return await authRepository.signUp(params);
  }
}
