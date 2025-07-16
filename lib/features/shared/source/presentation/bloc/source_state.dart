part of 'source_bloc.dart';

abstract class SourceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SourceInitial extends SourceState {}

class SourceInProgress extends SourceState {}

class SourceFailure extends SourceState {
  final String message;

  SourceFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AllSourcesSuccess extends SourceState {
  final List<Source> sources;

  AllSourcesSuccess({required this.sources});

  @override
  List<Object?> get props => [sources];
}
