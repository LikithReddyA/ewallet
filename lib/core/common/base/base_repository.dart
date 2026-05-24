import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
