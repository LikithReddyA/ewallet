import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';

abstract class ThemeRepository {
  Future<Either<Failure, Unit>> saveThemeMode(AppThemeMode appThemeMode);
  Future<Either<Failure, AppThemeMode>> getSavedThemeMode();
}
