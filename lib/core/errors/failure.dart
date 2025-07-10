import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class FirebaseAuthFailure extends Failure {
  final String firebaseFailureMessage;

  const FirebaseAuthFailure({required this.firebaseFailureMessage})
    : super(message: firebaseFailureMessage);

  @override
  List<Object?> get props => [message];
}

class FirestoreFailure extends Failure {
  final String firestoreFailureMessage;

  const FirestoreFailure({required this.firestoreFailureMessage})
    : super(message: firestoreFailureMessage);

  @override
  List<Object?> get props => [firestoreFailureMessage];
}

class ServerFailure extends Failure {
  final String serverFailureMessage;

  const ServerFailure({required this.serverFailureMessage})
    : super(message: serverFailureMessage);
  @override
  List<Object?> get props => [serverFailureMessage];
}
