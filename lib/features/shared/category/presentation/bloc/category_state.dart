part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryInProgress extends CategoryState {}

class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CategoriesSuccess extends CategoryState {
  final List<Category> categories;

  CategoriesSuccess({required this.categories});

  @override
  List<Object?> get props => [categories];
}
