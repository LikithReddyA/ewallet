import 'package:auth_repository/auth_repository.dart';
import 'package:ewallet/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ewallet/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authRepo, required this.walletRepo});

  final AuthRepo authRepo;
  final WalletRepo walletRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider.value(value: walletRepo),
      ],
      child: BlocProvider(
        create: (BuildContext context) =>
            AuthBloc(myAuthRepo: authRepo, myWalletRepo: walletRepo),
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
