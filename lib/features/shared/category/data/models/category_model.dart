import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String categoryId;
  final String iconKey;
  final String categoryName;
  final int colorHex;
  final String categoryType;

  const CategoryModel({
    required this.categoryId,
    required this.iconKey,
    required this.categoryName,
    required this.categoryType,
    this.colorHex = 0xFF9E9E9E,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> doc) {
    return CategoryModel(
      categoryId: doc['categoryId'] as String? ?? '',
      iconKey: doc['iconKey'] as String? ?? '',
      categoryName: doc['categoryName'] as String? ?? '',
      categoryType: doc['categoryType'] as String? ?? '',
      colorHex: doc['colorHex'] as int? ?? 0xFF9E9E9E,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'iconKey': iconKey,
      'categoryName': categoryName,
      'categoryType': categoryType,
      'colorHex': colorHex,
    };
  }

  @override
  List<Object?> get props => [
    categoryId,
    iconKey,
    categoryName,
    colorHex,
    categoryType,
  ];
}
