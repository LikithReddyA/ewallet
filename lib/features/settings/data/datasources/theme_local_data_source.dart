abstract class ThemeLocalDataSource {
  Future<String?> getThemeMode();
  Future<void> saveThemeMode(String mode);
}
