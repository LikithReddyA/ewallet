import 'package:ewallet/config/dependency_injection/injection_container.dart';
import 'package:ewallet/config/routes/app_router.dart';
import 'package:ewallet/core/constants/app_strings.dart';
import 'package:ewallet/core/theme/app_theme.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_event.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ewallet/features/settings/presentation/bloc/theme_cubit.dart';
import 'package:ewallet/features/settings/presentation/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((_) => sl<AuthBloc>()..add(AppStarted()))),
        BlocProvider(create: ((context) => sl<ThemeCubit>()..loadTheme())),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: ((previous, current) =>
          previous.themeMode != current.themeMode),
      builder: (context, themeState) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router(authBloc),
          title: AppStrings.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode.toFlutterThemeMode(),
        );
      },
    );
  }
}
