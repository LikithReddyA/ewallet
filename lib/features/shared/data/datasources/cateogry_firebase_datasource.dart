import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/shared/data/datasources/category_datasource.dart';
import 'package:ewallet/features/shared/data/models/category_model.dart';

class CateogryFirebaseDatasource implements CategoryDatasource {
  final FirebaseFirestore firebaseFirestore;

  CateogryFirebaseDatasource({required this.firebaseFirestore});
  @override
  Future<CategoryModel> getCategoryById(
    String categoryId,
    String userId,
  ) async {
    try {
      final userProfile = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .get();
      final List<dynamic> categoriesJson = userProfile.get("categories");
      final List<CategoryModel> categories = categoriesJson
          .map((doc) => CategoryModel.fromJson(doc))
          .toList();
      return categories.firstWhere(
        (element) => element.categoryId == categoryId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
