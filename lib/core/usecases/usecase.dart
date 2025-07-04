import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
