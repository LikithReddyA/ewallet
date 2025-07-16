import 'package:ewallet/features/shared/category/data/models/category_model.dart';

abstract class CategoryDatasource {
  Future<CategoryModel> getCategoryById(String categoryId, String userId);
  Future<void> addCategory(CategoryModel categoryModel, String userId);
  Future<List<CategoryModel>> getCategoriesByType(
    String categoryType,
    String userId,
  );
}
