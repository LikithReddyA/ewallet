import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/utils/helpers/firebase_helper.dart';
import 'package:ewallet/features/expense/data/datasources/expense_datasource.dart';
import 'package:ewallet/features/expense/data/mapper/expense_mapper.dart';
import 'package:ewallet/features/expense/domain/entities/expense.dart';
import 'package:ewallet/features/expense/domain/repositories/expense_repository.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/category/domain/repositories/category_repository.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final FirebaseHelper firebaseHelper;
  final SourceRepository sourceRepository;
  final ExpenseDatasource expenseDatasource;
  final CategoryRepository categoryRepository;

  ExpenseRepositoryImpl({
    required this.firebaseHelper,
    required this.sourceRepository,
    required this.expenseDatasource,
    required this.categoryRepository,
  });

  @override
  Future<Either<Failure, void>> addExpense(ExpenseParams params) async {
    try {
      final userId = await firebaseHelper.getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }

      // save the transaction
      await expenseDatasource.addExpense(
        userId,
        ExpenseMapper.toModel(
          Expense(
            id: params.expenseId,
            title: params.title,
            description: params.description,
            amount: params.amount,
            createdAt: DateTime.now(),
            transactionDate: params.transactionDate,
            transactionCategory: params.transactionCategory,
            transactionType: params.transactionType,
            fromSource: params.fromSource,
          ),
        ),
      );

      // update balance in source
      await sourceRepository.subtractBalance(
        params.fromSource.sourceId,
        params.amount,
      );

      // ignore: void_checks
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> fetchAllExpenses() async {
    try {
      final userId = await firebaseHelper.getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }

      final expenseModels = await expenseDatasource.fetchAllExpenses(userId);

      // Create a list of futures of Either<Failure,Expense>
      final List<Future<Either<Failure, Expense>>> futureExpenseResults =
          expenseModels.map<Future<Either<Failure, Expense>>>((
            expenseModel,
          ) async {
            final categoryResult = await categoryRepository.getCategoryById(
              expenseModel.transactionCategoryId,
            );

            final sourceResult = await sourceRepository.getSourceById(
              expenseModel.fromSourceId,
            );

            // Handle Category
            Category? category;
            final categoryFailure = categoryResult.fold((failure) => failure, (
              value,
            ) {
              category = value;
              return null;
            });

            if (categoryFailure != null) {
              return Left(categoryFailure);
            }

            // Handle Source
            Source? source;
            final sourceFailure = sourceResult.fold((failure) => failure, (
              value,
            ) {
              source = value;
              return null;
            });

            if (sourceFailure != null) {
              return Left(sourceFailure);
            }
            return Right(
              ExpenseMapper.toEntity(expenseModel, category!, source!),
            );
          }).toList();

      // Wait for all futures to complete
      final List<Either<Failure, Expense>> results = await Future.wait(
        futureExpenseResults,
      );

      // Check results for any failure
      List<Expense> expenses = [];
      for (final result in results) {
        if (result.isLeft()) {
          return Left(
            result.fold(
              (l) => l,
              (_) =>
                  ServerFailure(serverFailureMessage: "something-went-wrong"),
            ),
          );
        }
        expenses.add(result.getOrElse(() => throw UnimplementedError()));
      }

      return Right(expenses);
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }
}
