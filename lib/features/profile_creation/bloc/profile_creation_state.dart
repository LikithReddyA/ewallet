part of 'profile_creation_bloc.dart';

abstract class ProfileCreationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileCreationInitialState extends ProfileCreationState {}

class ProfileCreationInprogressState extends ProfileCreationState {}

class ProfileCreationSuccessState extends ProfileCreationState {}

class ProfileCreationFailureState extends ProfileCreationState {}
