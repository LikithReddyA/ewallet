import 'package:ewallet/config/app/presentation/shells/main_navigation_shell.dart';
import 'package:ewallet/config/routes/go_router_refresh_stream.dart';
import 'package:ewallet/config/routes/router_names.dart';
import 'package:ewallet/config/routes/router_paths.dart';
import 'package:ewallet/features/auth/presentation/pages/email_verification_page.dart';
import 'package:ewallet/features/auth/presentation/pages/login_page.dart';
import 'package:ewallet/features/auth/presentation/pages/register_page.dart';
import 'package:ewallet/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:ewallet/features/insights/presentation/pages/insights_page.dart';
import 'package:ewallet/features/profile/presentation/pages/profile_page.dart';
import 'package:ewallet/features/transactions/presentation/pages/transaction_page.dart';

import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';

class AppRouter {
  AppRouter._();
  static GoRouter router(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: RoutePaths.login,

      refreshListenable: GoRouterRefreshStream(authBloc.stream),

      redirect: (context, state) {
        final authStatus = authBloc.state.authStatus;

        final isAuthRoute =
            state.matchedLocation == RoutePaths.login ||
            state.matchedLocation == RoutePaths.register;

        final isVerificationRoute =
            state.matchedLocation == RoutePaths.emailVerification;

        switch (authStatus) {
          case AuthStatus.authenticated:
            if (isAuthRoute || isVerificationRoute) {
              return RoutePaths.dashboard;
            }
            return null;

          case AuthStatus.unverified:
            if (!isVerificationRoute) {
              return RoutePaths.emailVerification;
            }
            return null;

          case AuthStatus.unauthenticated:
            if (!isAuthRoute) {
              return RoutePaths.login;
            }
            return null;

          default:
            return null;
        }
      },
      routes: [
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (_, _) => const LoginPage(),
        ),

        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (_, _) => const RegisterPage(),
        ),

        GoRoute(
          path: RoutePaths.emailVerification,
          name: RouteNames.emailVerification,
          builder: (_, _) => const EmailVerificationPage(),
        ),

        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainNavigationShell(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.dashboard,
                  name: RouteNames.dashboard,
                  builder: (_, _) => const DashboardPage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.transactions,
                  name: RouteNames.transactions,
                  builder: (_, _) => const TransactionPage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.insights,
                  name: RouteNames.insights,
                  builder: (_, _) => const InsightsPage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.profile,
                  name: RouteNames.profile,
                  builder: (_, _) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
