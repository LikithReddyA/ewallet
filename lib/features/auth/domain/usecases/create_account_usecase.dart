import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/entities/app_session.dart';
import 'package:ewallet/features/auth/domain/params/register_params.dart';
import 'package:ewallet/features/auth/domain/params/create_account_params.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/profile/domain/enums/onboarding_status.dart';
import 'package:ewallet/features/profile/domain/params/user_profile_params.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';

class CreateAccountUsecase implements UseCase<AppSession, CreateAccountParams> {
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;

  const CreateAccountUsecase({
    required this.authRepository,
    required this.userProfileRepository,
  });

  @override
  Future<Either<Failure, AppSession>> call(CreateAccountParams params) async {
    final authResult = await authRepository.register(
      RegisterParams(email: params.email, password: params.password),
    );
    if (authResult.isLeft()) {
      return authResult.fold(Left.new, (_) => throw StateError("Unreachable"));
    }

    final authUser = authResult.getOrElse(
      () => throw StateError('Unreachable'),
    );

    final userProfileResult = await userProfileRepository.createUserProfile(
      UserProfileParams(
        userId: authUser.id,
        email: authUser.email,
        displayName: params.displayName ?? "A Likith Reddy",
        photoUrl: params.photoUrl,
        countryCode: "en_In",
        onboardingStatus: OnboardingStatus.pendingSource,
      ),
    );

    if (userProfileResult.isLeft()) {
      await authRepository.deleteCurrentUser();

      return userProfileResult.fold(
        Left.new,
        (_) => throw StateError('Unreachable'),
      );
    }

    final userProfile = userProfileResult.getOrElse(
      () => throw StateError('Unreachable'),
    );

    return Right(AppSession(authUser: authUser, userProfile: userProfile));
  }
}
