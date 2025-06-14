import 'package:ewallet/features/log_in/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ],
      ),
      body: Center(child: Text("Home page!")),
    );
  }
}
