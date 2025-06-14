import 'package:auth_repository/auth_repository.dart';
import 'package:ewallet/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ewallet/app/router/go_route_steam_to_listenable.dart';
import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/app/router/simple_navigator_observer.dart';
import 'package:ewallet/features/home/home.dart';
import 'package:ewallet/features/log_in/log_in.dart';
import 'package:ewallet/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:ewallet/features/sign_up/views/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
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
        final allowedUnauthenticatedPages = [
          Routes.login.path,
          Routes.signup.path,
        ];
        final isAuthenticated =
            authBloc.state.status == AuthStatus.authenticated;
        final isOnAllowedUnauthenticatedPages = allowedUnauthenticatedPages
            .contains(state.matchedLocation);

        if (!isAuthenticated && !isOnAllowedUnauthenticatedPages) {
          return Routes.login.path;
        } else if (isAuthenticated && isOnAllowedUnauthenticatedPages) {
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
          builder: (context, state) {
            return BlocProvider(
              create: (_) => LoginCubit(authRepo: context.read<AuthRepo>()),
              child: Home(),
            );
          },
        ),
        GoRoute(
          path: Routes.login.path,
          name: Routes.login.name,
          builder: (context, state) => BlocProvider(
            create: (context) => LoginCubit(authRepo: context.read<AuthRepo>()),
            child: LoginPage(),
          ),
        ),
        GoRoute(
          path: Routes.signup.path,
          name: Routes.signup.name,
          builder: (context, state) => BlocProvider(
            create: (context) =>
                SignUpCubit(authRepo: context.read<AuthRepo>()),
            child: SignUpPage(),
          ),
        ),
      ],
    );
  }
}
