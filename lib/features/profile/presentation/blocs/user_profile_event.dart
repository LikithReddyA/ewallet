part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileCreation extends UserProfileEvent {
  final String username;
  final DateTime dob;
  final List<Source> sources;
  final List<Category> categories;

  UserProfileCreation({
    required this.username,
    required this.dob,
    required this.sources,
    required this.categories,
  });

  @override
  List<Object?> get props => [username, dob, sources, categories];
}

class IsProfileCreated extends UserProfileEvent {}
