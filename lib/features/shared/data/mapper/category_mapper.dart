import 'package:ewallet/features/shared/data/models/category_model.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';

class CategoryMapper {
  static CategoryModel toModel(Category category) {
    return CategoryModel(
      categoryId: category.categoryId,
      iconKey: category.iconKey,
      categoryName: category.categoryName,
      categoryType: categoryTypeToString(category.categoryType),
      colorHex: category.colorHex,
    );
  }

  static List<CategoryModel> toModelList(List<Category> categories) {
    return categories.map((e) => toModel(e)).toList();
  }

  static Category toEntity(CategoryModel categoryModel) {
    return Category(
      categoryId: categoryModel.categoryId,
      iconKey: categoryModel.iconKey,
      categoryName: categoryModel.categoryName,
      categoryType: stringToCategoryType(categoryModel.categoryType),
      colorHex: categoryModel.colorHex,
    );
  }

  static List<Category> toEntityList(List<CategoryModel> categoryModels) {
    return categoryModels.map((e) => toEntity(e)).toList();
  }

  static CategoryType stringToCategoryType(String value) {
    return CategoryType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CategoryType.expense,
    );
  }

  static String categoryTypeToString(CategoryType type) => type.name;
}
