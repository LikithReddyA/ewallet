import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/income/domain/usecases/add_income_usecase.dart';
import 'package:ewallet/features/income/domain/usecases/fectch_all_incomes_usecase.dart';
import 'package:ewallet/features/income/domain/usecases/income_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final AddIncomeUsecase addIncomeUsecase;
  final FectchAllIncomesUsecase fectchAllIncomesUsecase;

  IncomeBloc({
    required this.addIncomeUsecase,
    required this.fectchAllIncomesUsecase,
  }) : super(IncomeInitial()) {
    on<AddIncome>(_onAddIncome);
    on<FetchAllIncomes>(_onFetchAllIncomes);
  }

  FutureOr<void> _onAddIncome(
    AddIncome event,
    Emitter<IncomeState> emit,
  ) async {
    emit(IncomeLoading());
    final result = await addIncomeUsecase(event.params);
    result.fold(
      (failure) => emit(FetchIncomesError(fetchIncomesError: failure.message!)),
      (_) => emit(AddIncomeSuccess()),
    );
  }

  FutureOr<void> _onFetchAllIncomes(
    FetchAllIncomes event,
    Emitter<IncomeState> emit,
  ) async {
    emit(IncomeLoading());
    final result = await fectchAllIncomesUsecase(NoParams());
    result.fold(
      (failure) => emit(FetchIncomesError(fetchIncomesError: failure.message!)),
      (incomes) => emit(AllIncomeSuccess(allIncomeTransactions: incomes)),
    );
  }
}
