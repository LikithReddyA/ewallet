import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Category>> getCategoryById(String categoryId);
  Future<Either<Failure, void>> addCategory(Category category);
  Future<Either<Failure, List<Category>>> getCategoriesByType(
    CategoryType categoryType,
  );
}
