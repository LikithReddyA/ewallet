import 'package:equatable/equatable.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';

class ThemeState extends Equatable {
  final AppThemeMode themeMode;
  final bool isLoading;
  final String? errorMessage;

  const ThemeState({
    required this.themeMode,
    this.isLoading = false,
    this.errorMessage,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [themeMode, isLoading, errorMessage];
}
