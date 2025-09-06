import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/expense/domain/entities/expense.dart';
import 'package:ewallet/features/expense/domain/repositories/expense_repository.dart';

class FetchAllExpensesUsecase implements Usecase<List<Expense>, NoParams> {
  final ExpenseRepository expenseRepository;

  FetchAllExpensesUsecase({required this.expenseRepository});

  @override
  Future<Either<Failure, List<Expense>>> call(NoParams params) async {
    return await expenseRepository.fetchAllExpenses();
  }
}
