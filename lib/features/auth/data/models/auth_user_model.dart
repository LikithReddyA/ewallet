import 'package:ewallet/features/auth/domain/entities/auth_user.dart';

class AuthUserModel {
  final String id;
  final String email;
  final bool isEmailVerified;

  const AuthUserModel({
    required this.id,
    required this.email,
    required this.isEmailVerified,
  });

  AuthUser toEntity() {
    return AuthUser(id: id, email: email, isEmailVerified: isEmailVerified);
  }
}
