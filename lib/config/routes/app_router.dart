import 'package:ewallet/config/routes/go_router_refresh_stream.dart';
import 'package:ewallet/config/routes/router_names.dart';
import 'package:ewallet/config/routes/router_paths.dart';
import 'package:ewallet/features/auth/presentation/pages/login_page.dart';
import 'package:ewallet/features/auth/presentation/pages/register_page.dart';
import 'package:ewallet/features/dashboard/presentation/pages/dashboard_page.dart';

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
        final isAuthenticated =
            authBloc.state.authStatus == AuthStatus.authenticated;

        final isAuthRoute =
            state.matchedLocation == RoutePaths.login ||
            state.matchedLocation == RoutePaths.register;

        // Not logged in
        if (!isAuthenticated && !isAuthRoute) {
          return RoutePaths.login;
        }

        // Already logged in
        if (isAuthenticated && isAuthRoute) {
          return RoutePaths.dashboard;
        }

        return null;
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
          path: RoutePaths.dashboard,
          name: RouteNames.dashboard,
          builder: (_, _) => const DashboardPage(),
        ),
      ],
    );
  }
}
