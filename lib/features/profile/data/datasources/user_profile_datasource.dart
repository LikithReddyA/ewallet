import 'package:ewallet/features/profile/data/models/user_profile_model.dart';

abstract class UserProfileDatasource {
  Future<UserProfileModel> createUserProfile({
    required String userId,
    required String email,
    String? displayName,
    String? photoUrl,
    String? countryCode,
    String? onboardingStatus,
  });

  Future<UserProfileModel> updateUserProfile({
    required String userId,
    String? displayName,
    String? photoUrl,
    String? countryCode,
    String? onboardingStatus,
  });

  Future<UserProfileModel> getUserProfile(String userId);
}
