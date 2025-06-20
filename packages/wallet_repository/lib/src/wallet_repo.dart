import 'package:wallet_repository/src/models/models.dart';

abstract class WalletRepo {
  Future<void> addUserProfile(UserProfile userProfile, List<Bank> banks);
  Future<bool> isProfileCreated(String uid);
}
