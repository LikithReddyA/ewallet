part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

abstract class ExpenseError extends ExpenseState {
  final String expenseErrorMessage;

  ExpenseError({required this.expenseErrorMessage});

  @override
  List<Object?> get props => [expenseErrorMessage];
}

class AllExpensesError extends ExpenseError {
  final String allExpenseErrorMessage;

  AllExpensesError({required this.allExpenseErrorMessage})
    : super(expenseErrorMessage: allExpenseErrorMessage);

  @override
  List<Object?> get props => [allExpenseErrorMessage];
}

class AddExpenseError extends ExpenseError {
  final String addExpenseErrorMessage;

  AddExpenseError({required this.addExpenseErrorMessage})
    : super(expenseErrorMessage: addExpenseErrorMessage);
  @override
  List<Object?> get props => [addExpenseErrorMessage];
}

class AddExpenseSuccess extends ExpenseState {}

class AllExpensesSuccess extends ExpenseState {
  final List<Expense> allExpenseTransactions;

  AllExpensesSuccess({required this.allExpenseTransactions});

  @override
  List<Object?> get props => [allExpenseTransactions];
}
