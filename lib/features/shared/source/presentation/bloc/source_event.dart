part of 'source_bloc.dart';

abstract class SourceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllSources extends SourceEvent {}
