import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/shared/category/data/datasources/category_datasource.dart';
import 'package:ewallet/features/shared/category/data/mapper/category_mapper.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource categoryDatasource;
  final AuthRepository authRepository;

  CategoryRepositoryImpl({
    required this.categoryDatasource,
    required this.authRepository,
  });

  Future<String?> getCurrentUserId() async {
    final result = await authRepository.getCurrentUserId();
    return result.fold((failure) => null, (id) => id);
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String categoryId) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }
      final categoryModel = await categoryDatasource.getCategoryById(
        categoryId,
        userId,
      );
      return Right(CategoryMapper.toEntity(categoryModel));
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(firestoreFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(Category category) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }
      await categoryDatasource.addCategory(
        CategoryMapper.toModel(category),
        userId,
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
  Future<Either<Failure, List<Category>>> getCategoriesByType(
    CategoryType categoryType,
  ) async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }
      final categoryModels = await categoryDatasource.getCategoriesByType(
        categoryType.name,
        userId,
      );
      return Right(CategoryMapper.toEntityList(categoryModels));
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(firestoreFailureMessage: e.code));
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }
}
