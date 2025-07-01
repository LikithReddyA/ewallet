part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String emailId;
  final String password;

  SignUpRequested({required this.emailId, required this.password});

  @override
  List<Object?> get props => [emailId, password];
}

class SignInRequested extends AuthEvent {
  final String emailId;
  final String password;

  SignInRequested({required this.emailId, required this.password});

  @override
  List<Object?> get props => [emailId, password];
}

class SignOutRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final AuthUser? authUser;

  AuthUserChanged({required this.authUser});

  @override
  List<Object?> get props => [authUser];
}

class EmailVerificationRequested extends AuthEvent {}

class CheckVerificationStatus extends AuthEvent {}
