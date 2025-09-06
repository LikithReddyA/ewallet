import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/expense/domain/entities/expense.dart';
import 'package:ewallet/features/expense/domain/usecase/add_expense_usecase.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';
import 'package:ewallet/features/expense/domain/usecase/fetch_all_expenses_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final AddExpenseUsecase addExpenseUsecase;
  final FetchAllExpensesUsecase fetchAllExpensesUsecase;

  ExpenseBloc({
    required this.addExpenseUsecase,
    required this.fetchAllExpensesUsecase,
  }) : super(ExpenseInitial()) {
    on<AddExpense>(_onAddExpense);
    on<FetchAllExpenses>(_onFetchAllExpenses);
  }

  FutureOr<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await addExpenseUsecase(event.params);
    result.fold(
      (failure) =>
          emit(AddExpenseError(addExpenseErrorMessage: failure.message!)),
      (_) => emit(AddExpenseSuccess()),
    );
  }

  FutureOr<void> _onFetchAllExpenses(
    FetchAllExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await fetchAllExpensesUsecase(NoParams());

    result.fold(
      (failure) =>
          emit(AllExpensesError(allExpenseErrorMessage: failure.message!)),
      (expenses) => emit(AllExpensesSuccess(allExpenseTransactions: expenses)),
    );
  }
}
