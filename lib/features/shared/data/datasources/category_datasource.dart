import 'package:ewallet/features/shared/data/models/category_model.dart';

abstract class CategoryDatasource {
  Future<CategoryModel> getCategoryById(String categoryId, String userId);
}
