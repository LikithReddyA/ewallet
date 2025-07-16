import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/shared/category/data/datasources/category_datasource.dart';
import 'package:ewallet/features/shared/category/data/models/category_model.dart';

class CateogryFirebaseDatasource implements CategoryDatasource {
  final FirebaseFirestore firebaseFirestore;

  CateogryFirebaseDatasource({required this.firebaseFirestore});

  @override
  Future<void> addCategory(CategoryModel categoryModel, String userId) async {
    try {
      final userProfileRef = firebaseFirestore
          .collection("profiles")
          .doc(userId);
      final userProfile = await userProfileRef.get();
      if (userProfile.exists) {
        await firebaseFirestore
            .collection("profiles")
            .doc(userId)
            .collection("categories")
            .doc(categoryModel.categoryId)
            .set(categoryModel.toJson(), SetOptions(merge: false));
      } else {
        throw FirebaseException(
          plugin: "FirebaseFirestore",
          code: "user-profile-doesn't-exists",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getCategoryById(
    String categoryId,
    String userId,
  ) async {
    try {
      final categoryDocument = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("categories")
          .doc(categoryId)
          .get();
      if (categoryDocument.exists) {
        final data = categoryDocument.data();
        if (data != null) {
          return CategoryModel.fromJson(categoryDocument.data()!);
        } else {
          throw FirebaseException(
            plugin: "FirebaseFirestore",
            code: "empty-doc",
          );
        }
      } else {
        throw FirebaseException(
          plugin: "FirebaseFirestore",
          code: "invalid-category-id",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategoriesByType(
    String categoryType,
    String userId,
  ) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("categories")
          .where("categoryType", isEqualTo: categoryType)
          .get();

      final categories = querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }
}
