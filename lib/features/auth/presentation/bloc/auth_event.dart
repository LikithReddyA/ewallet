import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;

  //TODO: Make the display name mandatory later
  final String? displayName;
  final String? photoUrl;
  const RegisterRequested({
    this.displayName,
    this.photoUrl,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password,displayName,photoUrl];
}

class LogoutRequested extends AuthEvent {}

class RefreshUserRequested extends AuthEvent {}

class VerificationEmailRequested extends AuthEvent {}
