import 'package:ewallet/features/auth/data/models/auth_user_model.dart';

abstract class AuthDatasource {
  Future<AuthUserModel> signIn(String emailId, String password);
  Future<void> signOut();
}
