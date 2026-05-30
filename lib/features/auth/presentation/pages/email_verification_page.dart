import 'dart:async';
import 'package:ewallet/core/extensions/context_extension.dart';
import 'package:ewallet/core/theme/app_colors.dart';
import 'package:ewallet/core/theme/app_radius.dart';
import 'package:ewallet/core/theme/app_spacing.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_event.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_state.dart';
import 'package:ewallet/shared/helpers/snackbar_helper.dart';
import 'package:ewallet/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  static const int cooldownSeconds = 60;

  Timer? _timer;
  int _remainingSeconds = 0;

  bool get isCoolingDown => _remainingSeconds > 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() {
      _remainingSeconds = cooldownSeconds;
    });

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _onSendVerificationPressed(BuildContext context) {
    context.read<AuthBloc>().add(VerificationEmailRequested());
    _startCooldown();
  }

  void _onCheckStatusPressed(BuildContext context) {
    context.read<AuthBloc>().add(RefreshUserRequested());
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthStatus.error) {
                SnackbarHelper.showError(context, state.errorMessage!);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),

                /// Title
                Text(
                  "Verify Your Email",
                  style: context.theme.textTheme.headlineMedium,
                ),

                const SizedBox(height: AppSpacing.md),

                /// Subtitle
                Text(
                  "We have sent a verification email to your inbox. "
                  "Please verify your email to continue.",
                  style: context.theme.textTheme.bodyMedium,
                ),

                const SizedBox(height: AppSpacing.xl),

                /// Cooldown indicator
                if (isCoolingDown)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      "You can resend email in ${_formatTime(_remainingSeconds)}",
                      style: context.theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: AppSpacing.lg),

                /// Send verification button
                AppButton(
                  text: isCoolingDown
                      ? "Resend Email (wait)"
                      : "Send Verification Email",
                  onPressed: isCoolingDown
                      ? null
                      : () => _onSendVerificationPressed(context),
                ),

                const SizedBox(height: AppSpacing.md),

                /// Check status button
                AppButton(
                  text: "I Have Verified",
                  onPressed: () => _onCheckStatusPressed(context),
                ),

                const Spacer(),

                /// Optional hint
                Text(
                  "Didn’t receive email? Check spam folder.",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
