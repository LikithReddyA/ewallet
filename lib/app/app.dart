import 'package:auth_repository/auth_repository.dart';
import 'package:ewallet/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ewallet/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authRepo});

  final AuthRepo authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepo,
      child: BlocProvider(
        create: (BuildContext context) => AuthBloc(myAuthRepo: authRepo),
        child: Builder(
          builder: (context) {
            final router = AppRouter.appRouter(context);
            return MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
