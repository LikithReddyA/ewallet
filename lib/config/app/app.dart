import 'package:ewallet/config/dependency_injection/injection_container.dart';
import 'package:ewallet/config/routes/app_router.dart';
import 'package:ewallet/core/constants/app_strings.dart';
import 'package:ewallet/core/theme/app_theme.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: ((_) => sl<AuthBloc>()))],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = sl<AuthBloc>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router(authBloc),
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
