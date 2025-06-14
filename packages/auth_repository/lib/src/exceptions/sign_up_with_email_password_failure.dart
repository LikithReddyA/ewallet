/// {@template sign_up_with_email_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailPasswordFailure implements Exception {
  final String message;

  /// {@macro sign_up_with_email_password_failure}
  const SignUpWithEmailPasswordFailure([
    this.message =
        "An unkown exception occured while Sign Up with Email and Password",
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignUpWithEmailPasswordFailure.fromCode(String code) {
    switch (code) {
      case "invalid-email":
        return const SignUpWithEmailPasswordFailure(
          "Email is not valid for Signing up",
        );
      case "user-disabled":
        return const SignUpWithEmailPasswordFailure(
          "This is user is disabled so please contact support for help",
        );
      case "email-already-in-use":
        return const SignUpWithEmailPasswordFailure(
          "Account already exists with this email",
        );
      case "operation-not-allowed":
        return const SignUpWithEmailPasswordFailure(
          "Operation is not allowed. Please contact support",
        );
      case "week-password":
        return const SignUpWithEmailPasswordFailure(
          "Please enter a strong password",
        );
      default:
        return SignUpWithEmailPasswordFailure();
    }
  }
}
