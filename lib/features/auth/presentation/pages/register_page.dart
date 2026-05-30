import 'package:ewallet/shared/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ewallet/core/utils/validators/email_validator.dart';
import 'package:ewallet/core/utils/validators/password_validator.dart';

import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_event.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_state.dart';

import 'package:ewallet/shared/helpers/snackbar_helper.dart';
import 'package:ewallet/shared/widgets/app_button.dart';
import 'package:ewallet/shared/widgets/app_text_field.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    context.read<AuthBloc>().add(
      RegisterRequested(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.authStatus != current.authStatus ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          SnackbarHelper.showError(context, state.errorMessage!);
          return;
        }

        if (state.authStatus == AuthStatus.authenticated) {
          SnackbarHelper.showSuccess(context, 'Registration successful');
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    controller: _emailController,
                    hintText: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                    validator: EmailValidator.validate,
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                    obscureText: _obscurePassword,
                    validator: PasswordValidator.validate,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password',
                    obscureText: _obscureConfirmPassword,
                    validator: _validateConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state.authStatus == AuthStatus.loading;

                      return isLoading
                          ? AppLoader()
                          : AppButton(
                              text: 'Register',
                              onPressed: isLoading ? null : _submit,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
