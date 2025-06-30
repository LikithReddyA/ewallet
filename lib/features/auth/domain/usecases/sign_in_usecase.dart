import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';

class SignInUsecase implements Usecase<AuthUser, SignInParams> {
  final AuthRepository authRepository;

  SignInUsecase({required this.authRepository});
  @override
  Future<Either<Failure, AuthUser>> call(SignInParams params) async {
    return await authRepository.signIn(params);
  }
}
