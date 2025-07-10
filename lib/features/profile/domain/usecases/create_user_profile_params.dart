import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';

class CreateUserProfileParams {
  final String userId;
  final String username;
  final DateTime dob;
  final List<Source> sources;
  final List<Category> categories;

  const CreateUserProfileParams({
    required this.userId,
    required this.username,
    required this.dob,
    required this.sources,
    required this.categories,
  });
}
