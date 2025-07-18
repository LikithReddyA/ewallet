part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class AddExpenseError extends ExpenseState {
  final String message;

  AddExpenseError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AddExpenseSuccess extends ExpenseState {}

class AllExpensesSuccess extends ExpenseState {
  final List<Expense> allExpenseTransactions;

  AllExpensesSuccess({required this.allExpenseTransactions});

  @override
  List<Object?> get props => [allExpenseTransactions];
}
