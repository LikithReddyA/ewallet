abstract class UserProfileDatasource {
  Future<void> createUserProfile(String userId, String userName, String dob);

  Future<bool> isProfileCreated(String userId);
}
