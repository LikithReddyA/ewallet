part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddIncome extends IncomeEvent {
  final IncomeParams params;

  AddIncome({required this.params});

  @override
  List<Object?> get props => [params];
}

class FetchAllIncomes extends IncomeEvent {}
