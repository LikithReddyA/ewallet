import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/app/router/simple_navigator_observer.dart';
import 'package:ewallet/features/auth/presentation/pages/sign_in_page.dart';
import 'package:ewallet/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter appRouter(BuildContext context) {
    final observer = SimpleNavigatorObserver(onScreenView: null);
    return GoRouter(
      initialLocation: Routes.login.path,
      observers: [observer],
      routes: [
        GoRoute(
          path: Routes.home.path,
          name: Routes.home.name,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: Routes.login.path,
          name: Routes.login.name,
          builder: (context, state) => SignInPage(),
        ),
      ],
    );
  }
}
