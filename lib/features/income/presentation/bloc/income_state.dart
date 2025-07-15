part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncomeInitial extends IncomeState {}

class IncomeLoading extends IncomeState {}

class AddIncomeError extends IncomeState {
  final String message;

  AddIncomeError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AddIncomeSuccess extends IncomeState {}

class AllIncomeSuccess extends IncomeState {
  final List<Income> allIncomeTransactions;

  AllIncomeSuccess({required this.allIncomeTransactions});

  @override
  List<Object?> get props => [allIncomeTransactions];
}
