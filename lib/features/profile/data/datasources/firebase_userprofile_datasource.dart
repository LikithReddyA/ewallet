import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/data/models/user_profile_model.dart';

class FirebaseUserprofileDatasource implements UserProfileDatasource {
  final FirebaseFirestore firebaseFirestore;

  FirebaseUserprofileDatasource({required this.firebaseFirestore});

  @override
  Future<void> createUserProfile(
    String userId,
    String userName,
    String dob,
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
      );
      await docReference.set(userProfileModel.toJson());
    }
  }

  @override
  Future<bool> isProfileCreated(String userId) async {
    final docReference = firebaseFirestore.collection("profiles").doc(userId);
    final snapshot = await docReference.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}
