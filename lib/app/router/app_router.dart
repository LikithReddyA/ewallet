import 'package:ewallet/app/router/go_route_steam_to_listenable.dart';
import 'package:ewallet/app/router/navigation_keys.dart';
import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/app/router/simple_navigator_observer.dart';
import 'package:ewallet/app/widgets/nav_bar.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/auth/presentation/pages/sign_in_page.dart';
import 'package:ewallet/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ewallet/features/auth/presentation/pages/user_verification_page.dart';
import 'package:ewallet/features/home/presentation/pages/home_page.dart';
import 'package:ewallet/features/profile/presentation/pages/create_user_profile_page.dart';
import 'package:ewallet/features/profile/presentation/pages/profile_page.dart';
import 'package:ewallet/features/profile/presentation/pages/profile_page_gateway.dart';
import 'package:ewallet/features/statistics/presentation/statistics_page.dart';
import 'package:ewallet/features/transactions/presentation/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter appRouter(BuildContext context) {
    final observer = SimpleNavigatorObserver(onScreenView: null);
    final authBloc = context.read<AuthBloc>();
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Routes.home.path,
      refreshListenable: GoRouteSteamToListenable(authBloc.stream),
      redirect: (context, state) {
        final allowUnauthenticatedRoutes = [
          Routes.login.path,
          Routes.signUp.path,
        ];
        final isAuthenticated = authBloc.state is AuthSuccess;
        final isAuthUnverified = authBloc.state is AuthUnverified;
        final isUnAuthenticated = authBloc.state is AuthUnAuthenticated;
        final isOnAllowedPages = allowUnauthenticatedRoutes.contains(
          state.matchedLocation,
        );
        final isOnVerificationPage =
            state.matchedLocation == Routes.verificationPage.path;

        if (isUnAuthenticated && !isOnAllowedPages) {
          return Routes.login.path;
        }
        if (isAuthUnverified && !isOnVerificationPage) {
          return Routes.verificationPage.path;
        }
        if (isAuthenticated && (isOnVerificationPage || isOnAllowedPages)) {
          return Routes.profilePageGateway.path;
        }
        return null;
      },
      observers: [observer],
      routes: [
        GoRoute(
          path: Routes.login.path,
          name: Routes.login.name,
          builder: (context, state) => SignInPage(),
        ),
        GoRoute(
          path: Routes.signUp.path,
          name: Routes.signUp.name,
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: Routes.verificationPage.path,
          name: Routes.verificationPage.name,
          builder: (context, state) => UserVerificationPage(),
        ),
        GoRoute(
          path: Routes.createProfilePage.path,
          name: Routes.createProfilePage.name,
          builder: (context, state) => CreateUserProfilePage(),
        ),
        GoRoute(
          path: Routes.profilePageGateway.path,
          name: Routes.profilePageGateway.name,
          builder: (context, state) => ProfilePageGateway(),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          observers: [SimpleNavigatorObserver(onScreenView: null)],
          pageBuilder: (context, state, child) =>
              MaterialPage(child: NavBar(child: child)),
          routes: [
            GoRoute(
              path: Routes.home.path,
              name: Routes.home.name,
              builder: (context, state) => HomePage(),
            ),
            GoRoute(
              path: Routes.transactionsPage.path,
              name: Routes.transactionsPage.name,
              builder: (context, state) => TransactionsPage(),
            ),
            GoRoute(
              path: Routes.statisticsPage.path,
              name: Routes.statisticsPage.name,
              builder: (context, state) => StatisticsPage(),
            ),
            GoRoute(
              path: Routes.profilePage.path,
              name: Routes.profilePage.name,
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),
      ],
    );
  }
}
