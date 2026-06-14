import 'package:ewallet/features/profile/domain/enums/onboarding_status.dart';

class UserProfile {
  final String userId;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String countryCode;
  final OnboardingStatus onboardingStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.userId,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.countryCode,
    required this.onboardingStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  UserProfile copyWith({
    String? displayName,
    String? photoUrl,
    String? countryCode,
    OnboardingStatus? onboardingStatus,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      userId: userId,
      email: email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      countryCode: countryCode ?? this.countryCode,
      onboardingStatus: onboardingStatus ?? this.onboardingStatus,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
