import 'package:ewallet/features/shared/data/models/category_model.dart';
import 'package:ewallet/features/shared/data/models/source_model.dart';

abstract class UserProfileDatasource {
  Future<void> createUserProfile(
    String userId,
    String userName,
    String dob,
    List<SourceModel> sources,
    List<CategoryModel> categories,
  );

  Future<bool> isProfileCreated(String userId);
}
