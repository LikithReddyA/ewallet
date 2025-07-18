import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/expense/domain/repositories/expense_repository.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';

class AddExpenseUsecase implements Usecase<void, ExpenseParams> {
  final ExpenseRepository expenseRepository;

  AddExpenseUsecase({required this.expenseRepository});

  @override
  Future<Either<Failure, void>> call(ExpenseParams params) async {
    return await expenseRepository.addExpense(params);
  }
}
