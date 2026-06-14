import 'package:ewallet/features/profile/data/models/user_profile_model.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';
import 'package:ewallet/features/profile/domain/enums/onboarding_status.dart';

class UserProfileMapper {
  static UserProfile toEntity(UserProfileModel model) {
    return UserProfile(
      userId: model.userId,
      email: model.email,
      displayName: model.displayName,
      photoUrl: model.photoUrl,
      countryCode: model.countryCode,
      onboardingStatus: OnboardingStatusMapper.fromString(
        model.onboardingStatus,
      ),
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static UserProfileModel toModel(UserProfile entity) {
    return UserProfileModel(
      userId: entity.userId,
      email: entity.email,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      countryCode: entity.countryCode,
      onboardingStatus: entity.onboardingStatus.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
