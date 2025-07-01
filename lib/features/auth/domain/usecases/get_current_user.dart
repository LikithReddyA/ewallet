import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser implements Usecase<AuthUser, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, AuthUser>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
