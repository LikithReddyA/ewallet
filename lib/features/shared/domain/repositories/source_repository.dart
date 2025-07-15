import 'package:dartz/dartz.dart';
import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';

abstract class SourceRepository {
  Future<Either<Failure, Source>> getSourceById(String sourceId);
  Future<Either<Failure, void>> addSource(Source source);
  Future<Either<Failure, List<Source>>> getAllSources();
  Future<Either<Failure, void>> addBalance(String sourceId, Money amount);
  Future<Either<Failure, void>> subtractBalance(String sourceId, Money amount);
}
