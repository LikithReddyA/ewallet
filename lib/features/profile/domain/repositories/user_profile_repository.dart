import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';
import 'package:ewallet/features/profile/domain/params/get_user_profile_params.dart';
import 'package:ewallet/features/profile/domain/params/user_profile_params.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> createUserProfile(UserProfileParams userProfilePrams);

  Future<Either<Failure, UserProfile>> getUserProfile(GetUserProfileParams params);

  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfileParams params);

}
