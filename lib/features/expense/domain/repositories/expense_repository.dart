import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, void>> addExpense(ExpenseParams params);
}
