import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/errors/firebase_exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'exceptions.dart';

class FailureHandler {
  const FailureHandler._();

  static Failure handle(dynamic error) {
    /// Custom Exceptions
    if (error is AuthException) {
      return AuthFailure(error.message);
    }

    if (error is ServerException) {
      return ServerFailure(error.message);
    }

    /// Firebase Auth Exceptions
    if (error is FirebaseAuthException) {
      return AuthFailure(mapFirebaseAuthError(error));
    }

    if (error is CacheException) {
      return CacheFailure(error.message);
    }

    /// Fallback
    return UnkownFailure('Something went wrong. Please try again.');
  }
}
