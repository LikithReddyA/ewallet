import 'package:equatable/equatable.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';

class UserProfile extends Equatable {
  final String userId;
  final String userName;
  final DateTime dob;
  final List<Source> sources;
  final List<Category> categories;

  const UserProfile({
    required this.userId,
    required this.userName,
    required this.dob,
    required this.sources,
    required this.categories,
  });

  @override
  List<Object?> get props => [userId, userName, dob, sources, categories];
}
