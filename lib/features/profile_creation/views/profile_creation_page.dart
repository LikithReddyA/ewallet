import 'package:ewallet/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/features/profile_creation/profile_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_repository/wallet_repository.dart';

//TODO: Implement profile creation page instead of mocking the data
class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ProfileCreationPage"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<ProfileCreationBloc, ProfileCreationState>(
              builder: (BuildContext context, ProfileCreationState state) {
                if (state is ProfileCreationInprogressState) {
                  return CircularProgressIndicator();
                } else if (state is ProfileCreationSuccessState) {
                  return Text("Profile Created");
                } else {
                  return TextButton(
                    onPressed: () {
                      final uid = context.read<AuthBloc>().state.user?.uid;
                      final UserProfile userProfile = UserProfile(
                        fullName: "Likith Reddy A",
                        uid: uid ?? "12345",
                        // uid: "ICQJWYIbgOOc7w2bo2i6e8FtPMm",
                        email: "alikithreddy381@gmail.com",
                        isProfileCompleted: true,
                      );
                      final List<Bank> banks = [
                        Bank(
                          bankName: "HDFC Bank",
                          amount: "5000",
                          isPrimary: true,
                        ),
                      ];

                      context.read<ProfileCreationBloc>().add(
                        AddProfileCreationEvent(
                          userProfile: userProfile,
                          banks: banks,
                        ),
                      );
                    },
                    child: Text("Create Profile"),
                  );
                }
              },
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                context.goNamed(Routes.home.name);
              },
              child: Text("Homepage"),
            ),
          ],
        ),
      ),
    );
  }
}
