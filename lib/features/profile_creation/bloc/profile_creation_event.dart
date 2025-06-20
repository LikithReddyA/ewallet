part of 'profile_creation_bloc.dart';

abstract class ProfileCreationEvent extends Equatable {}

class AddProfileCreationEvent extends ProfileCreationEvent {
  final UserProfile userProfile;
  final List<Bank> banks;

  AddProfileCreationEvent({required this.userProfile, required this.banks});

  @override
  List<Object?> get props => [userProfile, banks];
}
