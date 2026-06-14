import 'package:ewallet/features/profile/domain/enums/onboarding_status.dart';

class UserProfileParams {
  final String userId;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? countryCode;
  final OnboardingStatus? onboardingStatus;

  UserProfileParams({
    required this.userId,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.countryCode,
    this.onboardingStatus,
  });
}
