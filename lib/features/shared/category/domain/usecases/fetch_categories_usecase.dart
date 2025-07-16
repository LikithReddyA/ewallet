import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/category/domain/repositories/category_repository.dart';

class FetchCategoriesUsecase extends Usecase<List<Category>, CategoryType> {
  final CategoryRepository categoryRepository;

  FetchCategoriesUsecase({required this.categoryRepository});
  @override
  Future<Either<Failure, List<Category>>> call(CategoryType params) async {
    return await categoryRepository.getCategoriesByType(params);
  }
}
