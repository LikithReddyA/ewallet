import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';

class AppSession {
    final AuthUser authUser;
    final UserProfile userProfile;

  AppSession({required this.authUser, required this.userProfile});
    }

