import 'package:cloud_firestore/cloud_firestore.dart' hide Source;
import 'package:dartz/dartz.dart';
import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/shared/source/data/datasources/source_datasource.dart';
import 'package:ewallet/features/shared/source/data/mapper/source_mapper.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';

class SourceRepositoryImpl extends SourceRepository {
  final SourceDatasource sourceDatasource;
  final AuthRepository authRepository;

  SourceRepositoryImpl({
    required this.sourceDatasource,
    required this.authRepository,
  });

  Future<String?> getCurrentUserId() async {
    final result = await authRepository.getCurrentUserId();
    return result.fold((failure) => null, (id) => id);
  }

  @override
  Future<Either<Failure, void>> addSource(Source source) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }
      await sourceDatasource.addSource(SourceMapper.toModel(source), userId);
      // ignore: void_checks
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(firestoreFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Source>> getSourceById(String sourceId) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }

      final sourceModel = await sourceDatasource.getSourceById(
        sourceId,
        userId,
      );

      return Right(SourceMapper.toEntity(sourceModel));
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(firestoreFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Source>>> getAllSources() async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }

      final sources = await sourceDatasource.getAllSources(userId);
      return Right(SourceMapper.toEntityList(sources));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addBalance(
    String sourceId,
    Money amount,
  ) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }
      await sourceDatasource.addBalance(userId, sourceId, amount.amountInPaise);

      // ignore: void_checks
      return Right(Unit);
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> subtractBalance(
    String sourceId,
    Money amount,
  ) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }
      await sourceDatasource.subtractBalance(
        userId,
        sourceId,
        amount.amountInPaise,
      );

      // ignore: void_checks
      return Right(Unit);
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }
}
