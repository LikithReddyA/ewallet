import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/core/constants/view_constatnts.dart';
import 'package:ewallet/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
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
                      context.read<SignUpCubit>().signUp(
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: Text("Sign Up!"),
                  ),
                  SizedBox(height: ViewConstatnts.widgetsHeightGap),
                  TextButton(
                    onPressed: () {
                      context.goNamed(Routes.login.name);
                    },
                    child: Text("Login"),
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
