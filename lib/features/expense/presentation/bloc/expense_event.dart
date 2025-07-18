part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddExpense extends ExpenseEvent {
  final ExpenseParams params;

  AddExpense({required this.params});

  @override
  List<Object?> get props => [params];
}

class FetchAllExpenses extends ExpenseEvent {}
