import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  final String emailId;
  final bool isVerified;

  const AuthUser({
    required this.uid,
    required this.emailId,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [uid, emailId, isVerified];
}
