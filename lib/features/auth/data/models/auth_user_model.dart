import 'package:equatable/equatable.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserModel extends Equatable {
  final String uid;
  final String emailId;
  final bool isVerified;

  const AuthUserModel({
    required this.uid,
    required this.emailId,
    required this.isVerified,
  });

  factory AuthUserModel.fromFirebase(User firebaseUser) {
    return AuthUserModel(
      uid: firebaseUser.uid,
      emailId: firebaseUser.email ?? "",
      isVerified: firebaseUser.emailVerified,
    );
  }

  AuthUser toEntity() {
    return AuthUser(uid: uid, emailId: emailId, isVerified: isVerified);
  }

  @override
  List<Object?> get props => [uid, emailId, isVerified];
}
