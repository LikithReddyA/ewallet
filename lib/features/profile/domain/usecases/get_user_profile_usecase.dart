import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';
import 'package:ewallet/features/profile/domain/params/get_user_profile_params.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';

class GetUserProfileUsecase
    implements UseCase<UserProfile, GetUserProfileParams> {
  final UserProfileRepository userProfileRepository;

  GetUserProfileUsecase({required this.userProfileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(GetUserProfileParams params) async {
    return await userProfileRepository.getUserProfile(params);
  }
}
