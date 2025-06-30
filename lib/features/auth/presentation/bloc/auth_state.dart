part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthUnverified extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthUser authUser;

  AuthSuccess({required this.authUser});
  @override
  List<Object?> get props => [authUser];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthUnAuthenticated extends AuthState {}
