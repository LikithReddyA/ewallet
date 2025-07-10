import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_params.dart';
import 'package:ewallet/features/shared/data/mapper/category_mapper.dart';
import 'package:ewallet/features/shared/data/mapper/source_mapper.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDatasource userProfileDatasource;

  UserProfileRepositoryImpl({required this.userProfileDatasource});
  @override
  Future<Either<Failure, void>> createUserProfile(
    CreateUserProfileParams params,
  ) async {
    try {
      await userProfileDatasource.createUserProfile(
        params.userId,
        params.username,
        params.dob.toIso8601String(),
        SourceMapper.toModelList(params.sources),
        CategoryMapper.toModelList(params.categories),
      );
      // ignore: void_checks
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(firestoreFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isProfileCreated(String userId) async {
    try {
      final status = await userProfileDatasource.isProfileCreated(userId);
      return Right(status);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(firestoreFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }
}
