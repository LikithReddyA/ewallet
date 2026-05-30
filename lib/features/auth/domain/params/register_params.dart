import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
