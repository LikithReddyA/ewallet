import 'package:ewallet/core/theme/app_colors.dart';
import 'package:ewallet/core/theme/app_radius.dart';
import 'package:ewallet/core/theme/app_spacing.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_event.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_state.dart';
import 'package:ewallet/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: AppSpacing.xl,
                      width: AppSpacing.xl,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(
                          AppRadius.lg,
                        ),
                        color: AppColors.primary,
                      ),
                      child: Icon(Icons.person),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Text(context.read<AuthBloc>().state.authUser!.email),
                  ],
                ),
                SizedBox(height: AppSpacing.lg),
                Divider(height: AppSpacing.xs),
                SizedBox(height: AppSpacing.lg),
                AppButton(
                  text: "Logout",
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  icon: Icons.logout_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
