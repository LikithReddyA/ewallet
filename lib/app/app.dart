import 'package:ewallet/app/router/app_router.dart';
import 'package:ewallet/app/themes/app_theme.dart';
import 'package:ewallet/bootstrap/dependency_injection.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/profile/presentation/blocs/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<UserProfileBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final router = AppRouter.appRouter(context);
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        },
      ),
    );
  }
}
