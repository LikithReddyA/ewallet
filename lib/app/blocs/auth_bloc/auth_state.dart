part of 'auth_bloc.dart';

enum AuthStatus { unkown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final bool? isProfileCreated;

  const AuthState._({
    this.status = AuthStatus.unkown,
    this.user,
    this.isProfileCreated,
  });

  const AuthState.unkown() : this._();

  const AuthState.authenticated(User user, bool isProfileCreated)
    : this._(
        status: AuthStatus.authenticated,
        user: user,
        isProfileCreated: isProfileCreated,
      );

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user, isProfileCreated];
}
