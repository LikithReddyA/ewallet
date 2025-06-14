part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitial implements SignUpState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class SignUpInProcess implements SignUpState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class SignUpSuccessful implements SignUpState {
  final String uid;

  SignUpSuccessful({required this.uid});
  @override
  List<Object?> get props => [uid];

  @override
  bool? get stringify => false;
}

class SignUpFailure implements SignUpState {
  final String errorMsg;

  SignUpFailure({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];

  @override
  bool? get stringify => false;
}
