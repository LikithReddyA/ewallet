import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/core/constants/asset_constants.dart';
import 'package:ewallet/core/constants/view_constatnts.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/shared/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double size = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ViewConstatnts.pagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size,
              width: size,
              child: Image.asset(AssetConstants.logo, fit: BoxFit.cover),
            ),
            SizedBox(height: ViewConstatnts.widgetsHeightGap),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(height: ViewConstatnts.widgetsHeightGap),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(height: ViewConstatnts.widgetsHeightGap * 2),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthInProgress) {
                  return LoaderWidget();
                } else {
                  return Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            SignUpRequested(
                              emailId: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        child: Text("Sign Up"),
                      ),
                      SizedBox(height: ViewConstatnts.widgetsHeightGap),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("If you already have an account?"),
                          SizedBox(width: ViewConstatnts.widgetsHeightGap),
                          TextButton(
                            onPressed: () {
                              context.goNamed(Routes.login.name);
                            },
                            child: Text("Login!"),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
