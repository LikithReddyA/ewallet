import 'package:ewallet/config/routes/router_names.dart';
import 'package:ewallet/config/routes/router_paths.dart';
import 'package:ewallet/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: RoutePaths.splash,

  routes: [
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash,
      builder: (context, state) {
        return const SplashPage();
      },
    ),
  ],
);
