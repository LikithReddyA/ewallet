import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Category>> getCategoryById(
    String categoryId,
    String userId,
  );
}
