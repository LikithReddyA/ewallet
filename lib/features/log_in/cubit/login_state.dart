part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  @override
  bool? get stringify => false;

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccessful extends LoginState {
  final String uid;

  LoginSuccessful({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
