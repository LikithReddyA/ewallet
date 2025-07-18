import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/category/domain/usecases/fetch_categories_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final FetchCategoriesUsecase fetchCategoriesUsecase;

  CategoryBloc({required this.fetchCategoriesUsecase})
    : super(CategoryInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  FutureOr<void> _onFetchCategories(
    FetchCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryInProgress());
    final result = await fetchCategoriesUsecase(event.categoryType);
    result.fold(
      (failure) => emit(CategoryFailure(message: failure.message!)),
      (categories) => emit(CategoriesSuccess(categories: categories)),
    );
  }
}
