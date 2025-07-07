import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.goNamed(Routes.createProfilePage.name);
          },
          child: Text("Create Profile Page"),
        ),
      ),
    );
  }
}
