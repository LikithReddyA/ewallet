import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/core/constants/view_constatnts.dart';
import 'package:ewallet/features/log_in/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (BuildContext context, LoginState state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(ViewConstatnts.padding),
                    child: TextField(controller: _emailController),
                  ),
                  SizedBox(height: ViewConstatnts.widgetsHeightGap),
                  Padding(
                    padding: EdgeInsets.all(ViewConstatnts.padding),
                    child: TextField(controller: _passwordController),
                  ),
                  SizedBox(height: ViewConstatnts.widgetsHeightGap),
                  TextButton(
                    onPressed: () {
                      context.read<LoginCubit>().logIn(
                        _emailController.text,
                        _passwordController.text,
                      );
                      context.goNamed(Routes.profileCreation.name);
                    },
                    child: Text("Sign in"),
                  ),
                  SizedBox(height: ViewConstatnts.widgetsHeightGap),
                  TextButton(
                    onPressed: () {
                      context.goNamed(Routes.signup.name);
                    },
                    child: Text("Create Account"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
