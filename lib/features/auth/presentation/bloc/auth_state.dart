import 'package:equatable/equatable.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  unverified,
  error,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final AuthUser? authUser;
  final String? errorMessage;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.authUser,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    AuthUser? authUser,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      authUser: authUser ?? this.authUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [authStatus, authUser, errorMessage];
}
