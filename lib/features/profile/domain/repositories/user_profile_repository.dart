import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_params.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, void>> createUserProfile(
    CreateUserProfileParams params,
  );
}
