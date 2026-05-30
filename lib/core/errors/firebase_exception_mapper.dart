import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'No user found with this email';

    case 'wrong-password':
      return 'Incorrect password';

    case 'invalid-email':
      return 'Invalid email address';

    case 'user-disabled':
      return 'This account has been disabled';

    case 'too-many-requests':
      return 'Too many attempts. Try again later';

    case 'network-request-failed':
      return 'No internet connection';

    default:
      return e.message ?? 'Authentication failed';
  }
}
