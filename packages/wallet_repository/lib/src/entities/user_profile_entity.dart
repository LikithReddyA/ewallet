import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String fullName;
  final String uid;
  final String email;
  final bool isProfileCompleted;

  const UserProfileEntity({
    required this.fullName,
    required this.uid,
    required this.email,
    required this.isProfileCompleted,
  });

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'uid': uid,
      'email': email,
      'isProfileCompleted': isProfileCompleted,
    };
  }

  UserProfileEntity fromDocument(Map<String, dynamic> doc) {
    return UserProfileEntity(
      fullName: doc['fullName'],
      uid: doc['uid'],
      email: doc['email'],
      isProfileCompleted: doc['isProfileCompleted'],
    );
  }

  @override
  List<Object?> get props => [fullName, uid, email, isProfileCompleted];

  @override
  String toString() {
    return '''UserProfileEntity:{
      'fullName': $fullName,
      'uid': $uid,
      'email': $email,
      'isProfileCompleted': $isProfileCompleted
    }''';
  }
}
