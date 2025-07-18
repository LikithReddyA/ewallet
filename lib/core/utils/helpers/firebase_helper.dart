import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';

class FirebaseHelper {
  final AuthRepository authRepository;

  FirebaseHelper({required this.authRepository});

  Future<String?> getCurrentUserId() async {
    final result = await authRepository.getCurrentUserId();
    return result.fold((failure) => null, (id) => id);
  }
}
