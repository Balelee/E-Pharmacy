import 'package:flutter/material.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final bool isReadOnly;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? hintStyle;

  const CustomDropdownFormField(
      {super.key,
      required this.items,
      this.labelText,
      this.hintText,
      this.value,
      this.onChanged,
      this.validator,
      this.isExpanded = true,
      this.isReadOnly = false,
      this.prefix,
      this.suffix,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: isReadOnly ? null : onChanged,
      validator: validator,
      isExpanded: isExpanded,
      decoration: InputDecoration(
        labelText: labelText,
        hintStyle: hintStyle,
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
