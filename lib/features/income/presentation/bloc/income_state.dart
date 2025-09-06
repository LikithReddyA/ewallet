part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class IncomeSuccess extends IncomeState {}

abstract class IncomeError extends IncomeState {
  final String message;

  IncomeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class IncomeInitial extends IncomeState {}

class IncomeLoading extends IncomeState {}

class AddIncomeError extends IncomeError {
  final String addIncomeErrorMessage;

  AddIncomeError({required this.addIncomeErrorMessage})
    : super(message: addIncomeErrorMessage);
  @override
  List<Object?> get props => [addIncomeErrorMessage];
}

class FetchIncomesError extends IncomeError {
  final String fetchIncomesError;

  FetchIncomesError({required this.fetchIncomesError})
    : super(message: fetchIncomesError);
  @override
  List<Object?> get props => [fetchIncomesError];
}

class AddIncomeSuccess extends IncomeSuccess {}

class AllIncomeSuccess extends IncomeSuccess {
  final List<Income> allIncomeTransactions;

  AllIncomeSuccess({required this.allIncomeTransactions});

  @override
  List<Object?> get props => [allIncomeTransactions];
}
