import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/profile/data/constants/user_profile_fields.dart';

class UserProfileModel {
  final String userId;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String countryCode;
  final String onboardingStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfileModel({
    required this.userId,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.countryCode,
    required this.onboardingStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json[UserProfileFields.id],
      email: json[UserProfileFields.email] as String,
      displayName: json[UserProfileFields.displayName] as String,
      photoUrl: json[UserProfileFields.photoUrl] as String? ?? '',
      countryCode: json[UserProfileFields.countryCode] as String,
      onboardingStatus: json[UserProfileFields.onboardingStatus] as String,
      createdAt: (json[UserProfileFields.createdAt] as Timestamp).toDate(),
      updatedAt: (json[UserProfileFields.updatedAt] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserProfileFields.id: userId,
      UserProfileFields.email: email,
      UserProfileFields.displayName: displayName,
      UserProfileFields.countryCode: countryCode,
      UserProfileFields.onboardingStatus: onboardingStatus,
      UserProfileFields.photoUrl: photoUrl,
      UserProfileFields.createdAt: createdAt,
      UserProfileFields.updatedAt: updatedAt,
    };
  }
}
