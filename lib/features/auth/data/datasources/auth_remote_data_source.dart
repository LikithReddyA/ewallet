import 'package:ewallet/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login({
    required String email,
    required String password,
  });
  Future<AuthUserModel> register({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<AuthUserModel> getCurrentUser();
  Future<AuthUserModel> refreshUser();
  Future<void> sendVerificationEmail();
}
