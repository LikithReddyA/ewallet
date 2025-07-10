import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';

abstract class SourceRepository {
  Future<Either<Failure, Source>> getSourceById(String sourceId, String userId);
}
