import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/data/models/user_profile_model.dart';
import 'package:ewallet/features/shared/data/models/category_model.dart';
import 'package:ewallet/features/shared/data/models/source_model.dart';

class FirebaseUserprofileDatasource implements UserProfileDatasource {
  final FirebaseFirestore firebaseFirestore;

  FirebaseUserprofileDatasource({required this.firebaseFirestore});

  @override
  Future<void> createUserProfile(
    String userId,
    String userName,
    String dob,
    List<SourceModel> sources,
    List<CategoryModel> incomeCategories,
    List<CategoryModel> expenseCategories,
  ) async {
    final docReference = firebaseFirestore.collection("profiles").doc(userId);
    final snapshot = await docReference.get();
    if (snapshot.exists) {
      throw FirebaseException(
        plugin: "FirebaseFirestore",
        code: "doc-already-exists",
      );
    } else {
      final userProfileModel = UserProfileModel(
        userId: userId,
        userName: userName,
        dob: dob,
        sources: sources,
        incomeCategories: incomeCategories,
        expenseCategories: expenseCategories,
      );
      await docReference.set(userProfileModel.toJson());
    }
  }
}
