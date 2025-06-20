import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/features/log_in/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<LoginCubit>().logOut();
                },
                icon: Icon(Icons.logout),
              );
            },
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              context.goNamed(Routes.profileCreation.name);
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Center(child: Text("Home page!")),
    );
  }
}
