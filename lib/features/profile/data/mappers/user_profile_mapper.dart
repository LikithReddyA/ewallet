import 'package:ewallet/features/profile/data/models/user_profile_model.dart';
import 'package:ewallet/features/profile/domain/entities/user_profile.dart';
import 'package:ewallet/features/shared/data/mapper/category_mapper.dart';
import 'package:ewallet/features/shared/data/mapper/source_mapper.dart';

class UserProfileMapper {
  static UserProfileModel toModel(UserProfile userProfile) {
    return UserProfileModel(
      userId: userProfile.userId,
      userName: userProfile.userName,
      dob: userProfile.dob.toIso8601String(),
      sources: SourceMapper.toModelList(userProfile.sources),
      incomeCategories: CategoryMapper.toModelList(
        userProfile.incomeCategories,
      ),
      expenseCategories: CategoryMapper.toModelList(
        userProfile.expenseCategories,
      ),
    );
  }

  static UserProfile toEntity(UserProfileModel userProfileModel) {
    return UserProfile(
      userId: userProfileModel.userId,
      userName: userProfileModel.userName,
      dob: DateTime.parse(userProfileModel.dob),
      sources: SourceMapper.toEntityList(userProfileModel.sources),
      incomeCategories: CategoryMapper.toEntityList(
        userProfileModel.incomeCategories,
      ),
      expenseCategories: CategoryMapper.toEntityList(
        userProfileModel.expenseCategories,
      ),
    );
  }
}
