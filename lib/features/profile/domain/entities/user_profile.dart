import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId;
  final String userName;
  final DateTime dob;

  const UserProfile({
    required this.userId,
    required this.userName,
    required this.dob,
  });

  @override
  List<Object?> get props => [userId, userName, dob];
}
