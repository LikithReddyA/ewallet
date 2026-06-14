import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';
import 'package:ewallet/features/profile/domain/params/user_profile_params.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';

class UpdateUserProfileUsecase implements UseCase<UserProfile,UserProfileParams> {
  final UserProfileRepository userProfileRepository;

  UpdateUserProfileUsecase({required this.userProfileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(UserProfileParams params) async {
      return await userProfileRepository.updateUserProfile(params);
  }
}
