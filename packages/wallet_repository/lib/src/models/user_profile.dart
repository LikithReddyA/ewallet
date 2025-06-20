import 'package:equatable/equatable.dart';
import 'package:wallet_repository/src/entities/entities.dart';

class UserProfile extends Equatable {
  final String fullName;
  final String uid;
  final String email;
  final bool isProfileCompleted;

  const UserProfile({
    required this.fullName,
    required this.uid,
    required this.email,
    required this.isProfileCompleted,
  });

  static final empty = UserProfile(
    fullName: '',
    uid: '',
    email: '',
    isProfileCompleted: false,
  );

  UserProfile copyWith({
    String? fullName,
    String? uid,
    String? email,
    bool? isProfileCompleted,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      fullName: fullName,
      uid: uid,
      email: email,
      isProfileCompleted: isProfileCompleted,
    );
  }

  UserProfile fromEntity(UserProfileEntity entity) {
    return UserProfile(
      fullName: entity.fullName,
      uid: entity.uid,
      email: entity.email,
      isProfileCompleted: entity.isProfileCompleted,
    );
  }

  @override
  List<Object?> get props => [fullName, uid, email, isProfileCompleted];
}
