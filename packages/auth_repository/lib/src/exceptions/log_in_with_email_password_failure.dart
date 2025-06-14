/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailPasswordFailure implements Exception {
  final String message;

  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailPasswordFailure([
    this.message =
        "An unkown exception occured while Sign In with Email and Password",
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithEmailPasswordFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithEmailPasswordFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithEmailPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithEmailPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailPasswordFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithEmailPasswordFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithEmailPasswordFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithEmailPasswordFailure();
    }
  }
}
