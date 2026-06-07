import 'package:ewallet/core/errors/exceptions.dart';
import 'package:ewallet/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  static const String _themeModeKey = 'theme_mode';

  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getThemeMode() async {
    return sharedPreferences.getString(_themeModeKey);
  }

  @override
  Future<void> saveThemeMode(String mode) async {
    final isSaved = await sharedPreferences.setString(_themeModeKey, mode);

    if (!isSaved) {
      throw const CacheException('Failed to save theme mode');
    }
  }
}
