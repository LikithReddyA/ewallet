import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/app_session.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/profile/domain/params/get_user_profile_params.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';

class GetCurrentSessionUsecase implements UseCase<AppSession, NoParams> {
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;

  GetCurrentSessionUsecase({
    required this.authRepository,
    required this.userProfileRepository,
  });

  @override
  Future<Either<Failure, AppSession>> call(NoParams params) async {
    final authResult = await authRepository.getCurrentUser();
    if (authResult.isLeft()) {
      return authResult.fold(Left.new, (_) => throw StateError("Unreached"));
    }
    final authUser = authResult.getOrElse(() => throw StateError("Unreached"));

    final userProfileResult = await userProfileRepository.getUserProfile(
      GetUserProfileParams(userId: authUser.id),
    );

    if (userProfileResult.isLeft()) {
      return userProfileResult.fold(Left.new, (_) => throw StateError("Unreached"));
    }
    final userProfile = userProfileResult.getOrElse(
      () => throw StateError("Unreached"),
    );
    return Right(AppSession(authUser: authUser, userProfile: userProfile));
  }
}
