import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/shared/source/domain/usecases/get_sources_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  final GetSourcesUsecase getSourcesUsecase;

  SourceBloc({required this.getSourcesUsecase}) : super(SourceInitial()) {
    on<FetchAllSources>(_onFetchAllSources);
  }

  FutureOr<void> _onFetchAllSources(
    FetchAllSources event,
    Emitter<SourceState> emit,
  ) async {
    emit(SourceInProgress());
    try {
      final result = await getSourcesUsecase(NoParams());
      result.fold(
        (failure) => emit(SourceFailure(message: failure.message!)),
        (sources) => emit(AllSourcesSuccess(sources: sources)),
      );
    } catch (e) {
      emit(SourceFailure(message: e.toString()));
    }
  }
}
