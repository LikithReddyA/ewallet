import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/core/utils/helpers/ui_helpers.dart';
import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:ewallet/features/profile/presentation/blocs/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePageGateway extends StatelessWidget {
  const ProfilePageGateway({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, profileState) {
        if (profileState is UserProfileSuccess) {
          context.goNamed(Routes.home.name);
        } else if (profileState is UserProfileNotCreated) {
          context.goNamed(Routes.createProfilePage.name);
        } else if (profileState is UserProfileFailure) {
          showCustomSnackBar(context, profileState.message);
        }
      },
      child: Builder(
        builder: (context) {
          context.read<UserProfileBloc>().add(IsProfileCreated());
          return Scaffold(body: Center(child: LoaderWidget()));
        },
      ),
    );
  }
}
