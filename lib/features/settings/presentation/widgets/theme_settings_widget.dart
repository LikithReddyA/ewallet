import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ewallet/features/settings/presentation/bloc/theme_cubit.dart';
import 'package:ewallet/features/settings/presentation/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ThemeSettingsWidget extends StatelessWidget {
  const ThemeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeModeState) {
        return ListTile(
          leading: const Icon(Icons.palette_outlined),
          title: Text('Theme'),
          subtitle: Text(themeModeState.themeMode.toAppString()),
          onTap: () => _showThemeSheet(context, themeModeState.themeMode),
        );
      },
    );
  }
}

void _showThemeSheet(BuildContext context, AppThemeMode selectedTheme) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: RadioGroup<AppThemeMode>(
          groupValue: selectedTheme,
          onChanged: (value) {
            if (value != null) {
              context.pop();
              context.read<ThemeCubit>().saveTheme(value);
            }
          },
          child: Column(
            children: [
              RadioListTile(
                value: AppThemeMode.system,
                title: Text(AppThemeMode.system.toAppString()),
              ),
              RadioListTile(
                value: AppThemeMode.dark,
                title: Text(AppThemeMode.dark.toAppString()),
              ),
              RadioListTile(
                value: AppThemeMode.light,
                title: Text(AppThemeMode.light.toAppString()),
              ),
            ],
          ),
        ),
      );
    },
  );
}
