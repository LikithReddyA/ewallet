import 'package:ewallet/features/auth/data/models/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AuthUserMapper on User {
  AuthUserModel toModel() {
    return AuthUserModel(
      id: uid,
      email: email ?? '',
      isEmailVerified: emailVerified,
    );
  }
}
