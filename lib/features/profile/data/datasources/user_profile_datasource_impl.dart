import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/core/errors/exceptions.dart';
import 'package:ewallet/core/firestore/refs/user_ref.dart';
import 'package:ewallet/features/profile/data/constants/user_profile_fields.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/data/models/user_profile_model.dart';

class UserProfileDatasourceImpl implements UserProfileDatasource {
  final FirebaseFirestore firebaseFirestore;

  UserProfileDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<UserProfileModel> createUserProfile({
    required String userId,
    required String email,
    String? displayName,
    String? photoUrl,
    String? countryCode,
    String? onboardingStatus,
  }) async {
    try {
      final ref = UserRef.user(userId);

      final snapshot = await ref.get();

      if (snapshot.exists) {
        throw ServerException("User profile already exists");
      }

      final data = <String, dynamic>{
        UserProfileFields.id: userId,
        UserProfileFields.email: email,
        UserProfileFields.displayName: displayName,
        UserProfileFields.photoUrl: photoUrl,
        UserProfileFields.countryCode: countryCode,
        UserProfileFields.onboardingStatus: onboardingStatus,
        UserProfileFields.createdAt: FieldValue.serverTimestamp(),
        UserProfileFields.updatedAt: FieldValue.serverTimestamp(),
      };

      await ref.set(data);

      final createdSnapshot = await ref.get();

      if (!createdSnapshot.exists || createdSnapshot.data() == null) {
        throw ServerException("User profile not found after creation");
      }

      return UserProfileModel.fromJson(
        createdSnapshot.data() as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserProfileModel> getUserProfile(String userId) async {
    try {
      final ref = UserRef.user(userId);
      final snapshot = await ref.get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw ServerException("User profile not found");
      }

      return UserProfileModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserProfileModel> updateUserProfile({
    required String userId,
    String? displayName,
    String? photoUrl,
    String? countryCode,
    String? onboardingStatus,
  }) async {
    try {
      final ref = UserRef.user(userId);

      final updateData = <String, dynamic>{};

      if (displayName != null) {
        updateData[UserProfileFields.displayName] = displayName;
      }
      if (photoUrl != null) updateData[UserProfileFields.photoUrl] = photoUrl;
      if (countryCode != null) {
        updateData[UserProfileFields.countryCode] = countryCode;
      }
      if (onboardingStatus != null) {
        updateData[UserProfileFields.onboardingStatus] = onboardingStatus;
      }

      updateData[UserProfileFields.updatedAt] = FieldValue.serverTimestamp();

      if (updateData.length == 1) {
        // only updatedAt exists
        return await getUserProfile(userId);
      }

      await ref.update(updateData);

      final snapshot = await ref.get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw ServerException("User profile not found after update");
      }

      return UserProfileModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
