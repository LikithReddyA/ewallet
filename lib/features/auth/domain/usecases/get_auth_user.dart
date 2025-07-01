import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class GetAuthUser implements Usecase<Stream<AuthUser?>, NoParams> {
  final AuthRepository authRepository;

  GetAuthUser({required this.authRepository});
  @override
  Future<Either<Failure, Stream<AuthUser?>>> call(NoParams params) async {
    return await authRepository.getAuthUser();
  }
}
