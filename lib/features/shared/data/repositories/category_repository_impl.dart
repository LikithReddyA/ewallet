import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/shared/data/datasources/category_datasource.dart';
import 'package:ewallet/features/shared/data/mapper/category_mapper.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/shared/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource categoryDatasource;

  CategoryRepositoryImpl({required this.categoryDatasource});
  @override
  Future<Either<Failure, Category>> getCategoryById(
    String categoryId,
    String userId,
  ) async {
    try {
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
}
