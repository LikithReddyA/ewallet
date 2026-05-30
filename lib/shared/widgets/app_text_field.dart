import 'package:ewallet/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? hintText;

  final String? Function(String?)? validator;

  final bool obscureText;

  final TextInputType keyboardType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextInputAction? textInputAction;
  final bool enabled;

  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  final int? maxLines;
  final bool autofocus;

  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }
}
