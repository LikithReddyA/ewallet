import 'package:ewallet/core/constants/view_constatnts.dart';
import 'package:ewallet/core/utils/helpers/ui_helpers.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserVerificationPage extends StatelessWidget {
  const UserVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ViewConstatnts.pagePadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User verification notification has been sent to your email. Please verify your account!!",
              ),
              SizedBox(height: ViewConstatnts.widgetsHeightGap * 2),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInProgress) {
                    return LoaderWidget();
                  } else {
                    return TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(CheckVerificationStatus());
                      },
                      child: Text("Check Status!"),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is AuthUnverified) {
                    showCustomSnackBar(context, "User is not verified!");
                  }
                },
              ),
              SizedBox(height: ViewConstatnts.widgetsHeightGap * 2),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(EmailVerificationRequested());
                },
                child: Text("Resend Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
