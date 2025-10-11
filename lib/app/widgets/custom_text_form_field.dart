import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final Widget? suffix;
  final Function()? onTap;
  final bool isReadOnly;
  final TextStyle? hintStyle;
  final InputBorder? focusedBorder;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField(
      {super.key,
      this.controller,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.labelText,
      this.hintText,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.textInputAction,
      this.onFieldSubmitted,
      this.prefix,
      this.suffix,
      this.onTap,
      this.focusedBorder,
      this.isReadOnly = false,
      this.inputFormatters,
      this.hintStyle,
      this.helperText,
      this.errorStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: isReadOnly,
      onTap: onTap,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintStyle: hintStyle,
        helperText: helperText,
        errorStyle: errorStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: focusedBorder,
        filled: true,
        fillColor: AppColors.secondary,
      ),
      inputFormatters: inputFormatters,
    );
  }
}
