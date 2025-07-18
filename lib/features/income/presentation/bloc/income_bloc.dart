import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/income/domain/usecases/add_income_usecase.dart';
import 'package:ewallet/features/income/domain/usecases/income_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final AddIncomeUsecase addIncomeUsecase;

  IncomeBloc({required this.addIncomeUsecase}) : super(IncomeInitial()) {
    on<AddIncome>(_onAddIncome);
  }

  FutureOr<void> _onAddIncome(
    AddIncome event,
    Emitter<IncomeState> emit,
  ) async {
    emit(IncomeLoading());
    final result = await addIncomeUsecase(event.params);
    result.fold(
      (failure) => emit(AddIncomeError(message: failure.message!)),
      (_) => emit(AddIncomeSuccess()),
    );
  }
}
