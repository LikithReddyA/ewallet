part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String emailId;
  final String password;

  SignInRequested({required this.emailId, required this.password});

  @override
  List<Object?> get props => [emailId, password];
}

