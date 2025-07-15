import 'package:ewallet/features/profile/data/models/user_profile_model.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';

class UserProfileMapper {
  static UserProfileModel toModel(UserProfile userProfile) {
    return UserProfileModel(
      userId: userProfile.userId,
      userName: userProfile.userName,
      dob: userProfile.dob.toIso8601String(),
    );
  }

  static UserProfile toEntity(UserProfileModel userProfileModel) {
    return UserProfile(
      userId: userProfileModel.userId,
      userName: userProfileModel.userName,
      dob: DateTime.parse(userProfileModel.dob),
    );
  }
}
