import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/errors/failure_handler.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/data/mappers/user_profile_mapper.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';
import 'package:ewallet/features/profile/domain/params/get_user_profile_params.dart';
import 'package:ewallet/features/profile/domain/params/user_profile_params.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDatasource userProfileDatasource;

  UserProfileRepositoryImpl({required this.userProfileDatasource});

  @override
  Future<Either<Failure, UserProfile>> createUserProfile(
    UserProfileParams userProfilePrams,
  ) async {
    try {
      final result = await userProfileDatasource.createUserProfile(
        userId: userProfilePrams.userId,
        email: userProfilePrams.email,
        displayName: userProfilePrams.displayName,
        photoUrl: userProfilePrams.photoUrl,
        countryCode: userProfilePrams.countryCode,
        onboardingStatus: userProfilePrams.onboardingStatus?.name,
      );

      return Right(UserProfileMapper.toEntity(result));
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getUserProfile(
    GetUserProfileParams params,
  ) async {
    try {
      final result = await userProfileDatasource.getUserProfile(params.userId);
      return Right(UserProfileMapper.toEntity(result));
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfileParams params,
  ) async {
    try {
      final result = await userProfileDatasource.updateUserProfile(
        userId: params.userId,
        displayName: params.displayName,
        photoUrl: params.photoUrl,
        countryCode: params.countryCode,
        onboardingStatus: params.onboardingStatus?.name,
      );
      return Right(UserProfileMapper.toEntity(result));
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }
}
