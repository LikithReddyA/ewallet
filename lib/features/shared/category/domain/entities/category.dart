import 'package:equatable/equatable.dart';

enum CategoryType { expense, income }

class Category extends Equatable {
  final String categoryId;
  final String iconKey;
  final String categoryName;
  final int colorHex;
  final CategoryType categoryType;

  const Category({
    required this.categoryId,
    required this.iconKey,
    required this.categoryName,
    required this.categoryType,
    this.colorHex = 0xFF9E9E9E,
  });
  @override
  List<Object?> get props => [
    categoryId,
    iconKey,
    categoryName,
    colorHex,
    categoryType,
  ];
}
