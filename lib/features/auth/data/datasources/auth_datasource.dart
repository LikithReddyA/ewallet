import 'package:ewallet/features/auth/data/models/auth_user_model.dart';

abstract class AuthDatasource {
  Future<AuthUserModel> signUp(String emailId, String password);
  Future<AuthUserModel> signIn(String emailId, String password);
  Future<void> signOut();
  Stream<AuthUserModel?> getAuthUser();
  Future<void> sendVerificationEmail();
  Future<AuthUserModel> getCurrentUser();
  Future<String> getCurrentUserId();
}
