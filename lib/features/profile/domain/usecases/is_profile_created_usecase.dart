import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';

class IsProfileCreatedUsecase implements Usecase<bool, String> {
  final UserProfileRepository userProfileRepository;

  IsProfileCreatedUsecase({required this.userProfileRepository});
  @override
  Future<Either<Failure, bool>> call(String userId) async {
    return await userProfileRepository.isProfileCreated(userId);
  }
}
