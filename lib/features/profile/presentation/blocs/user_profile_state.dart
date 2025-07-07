part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileInprogress extends UserProfileState {}

class UserProfileFailure extends UserProfileState {
  final String message;

  UserProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserProfileNotCreated extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {}

class CreateUserProfileSuccess extends UserProfileState {}
