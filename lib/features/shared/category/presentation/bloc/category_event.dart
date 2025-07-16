part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategories extends CategoryEvent {
  final CategoryType categoryType;

  FetchCategories({required this.categoryType});

  @override
  List<Object?> get props => [categoryType];
}
