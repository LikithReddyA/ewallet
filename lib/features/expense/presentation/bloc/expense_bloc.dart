import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/features/expense/domain/entities/expense.dart';
import 'package:ewallet/features/expense/domain/usecase/add_expense_usecase.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final AddExpenseUsecase addExpenseUsecase;

  ExpenseBloc({required this.addExpenseUsecase}) : super(ExpenseInitial()) {
    on<AddExpense>(_onAddExpense);
  }

  FutureOr<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await addExpenseUsecase(event.params);
    result.fold(
      (failure) => emit(AddExpenseError(message: failure.message!)),
      (_) => emit(AddExpenseSuccess()),
    );
  }
}
