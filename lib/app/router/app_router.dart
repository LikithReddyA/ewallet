import 'package:ewallet/app/router/go_route_steam_to_listenable.dart';
import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/app/router/simple_navigator_observer.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/auth/presentation/pages/sign_in_page.dart';
import 'package:ewallet/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter appRouter(BuildContext context) {
    final observer = SimpleNavigatorObserver(onScreenView: null);
    final authBloc = context.read<AuthBloc>();
    return GoRouter(
      initialLocation: Routes.home.path,
      refreshListenable: GoRouteSteamToListenable(authBloc.stream),
      redirect: (context, state) {
        final allowUnauthenticatedRoutes = [Routes.login.path];
        final isAuthenticated = authBloc.state is AuthSuccess;
        final isAuthVerified = authBloc.state is AuthUnverified;
        final isOnAllowedPages = allowUnauthenticatedRoutes.contains(
          state.matchedLocation,
        );

        if (!(isAuthenticated || isAuthVerified) && !isOnAllowedPages) {
          return Routes.login.path;
        } else if ((isAuthenticated || isAuthVerified) && isOnAllowedPages) {
          return Routes.home.path;
        } else {
          return null;
        }
      },
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
