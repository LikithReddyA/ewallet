import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/utils/helpers/firebase_helper.dart';
import 'package:ewallet/features/expense/data/datasources/expense_datasource.dart';
import 'package:ewallet/features/expense/data/mapper/expense_mapper.dart';
import 'package:ewallet/features/expense/domain/entities/expense.dart';
import 'package:ewallet/features/expense/domain/repositories/expense_repository.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final FirebaseHelper firebaseHelper;
  final SourceRepository sourceRepository;
  final ExpenseDatasource expenseDatasource;

  ExpenseRepositoryImpl(
    this.firebaseHelper,
    this.sourceRepository, {
    required this.expenseDatasource,
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
}
