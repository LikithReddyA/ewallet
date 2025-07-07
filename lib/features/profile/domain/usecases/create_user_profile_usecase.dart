import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_params.dart';

class CreateUserProfileUsecase
    implements Usecase<void, CreateUserProfileParams> {
  final UserProfileRepository userProfileRepository;

  CreateUserProfileUsecase({required this.userProfileRepository});
  @override
  Future<Either<Failure, void>> call(CreateUserProfileParams params) async {
    return await userProfileRepository.createUserProfile(params);
  }
}
