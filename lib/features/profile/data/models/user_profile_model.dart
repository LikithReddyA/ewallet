import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String userId;
  final String userName;
  final String dob;

  const UserProfileModel({
    required this.userId,
    required this.userName,
    required this.dob,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> doc) {
    return UserProfileModel(
      userId: doc['userId'] as String? ?? '',
      userName: doc['userName'] as String? ?? '',
      dob: doc['dob'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName, 'dob': dob};
  }

  @override
  List<Object?> get props => [userId, userName, dob];
}
