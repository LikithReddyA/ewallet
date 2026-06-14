import 'package:equatable/equatable.dart';
import 'package:ewallet/features/auth/domain/entities/app_session.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';

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
  final AppSession? appSession;
  final String? errorMessage;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.appSession,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    AppSession? appSession,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      appSession: appSession ?? this.appSession,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  AuthUser? get authUser => appSession?.authUser;

  UserProfile? get userProfile => appSession?.userProfile;

  @override
  List<Object?> get props => [authStatus, appSession, errorMessage];
}
