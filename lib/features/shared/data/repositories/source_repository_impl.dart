import 'package:cloud_firestore/cloud_firestore.dart' hide Source;
import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/shared/data/datasources/source_datasource.dart';
import 'package:ewallet/features/shared/data/mapper/source_mapper.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';
import 'package:ewallet/features/shared/domain/repositories/source_repository.dart';

class SourceRepositoryImpl extends SourceRepository {
  final SourceDatasource sourceDatasource;

  SourceRepositoryImpl({required this.sourceDatasource});
  @override
  Future<Either<Failure, Source>> getSourceById(
    String sourceId,
    String userId,
  ) async {
    try {
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
}
