import 'package:flutter/material.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';

class CustomButton {
  static Widget primaryButton({
    required void Function()? onPressed,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Widget? leadingIcon,
    Widget? trailingIcon,
    Widget? child,
    required String buttonTitle,
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? textFontWeight,
    double? elevation,
    Color? textColor,
    double? borderRadius,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.black,
        backgroundColor: backgroundColor ?? AppColors.primary,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        ),
        elevation: elevation ?? 2.0,
      ),
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon,
                const SizedBox(width: 8.0),
              ],
              Text(
                buttonTitle,
                style: textStyle ?? AppTextStyles.buttonTextStyle,
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8.0),
                trailingIcon,
              ],
            ],
          ),
    );
  }

  static Widget secondaryButton({
    required void Function()? onPressed,
    Color? textColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Widget? leadingIcon,
    Widget? trailingIcon,
    required String buttonTitle,
    TextStyle? textStyle,
    double? fontSize,
    double? borderRadius,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: mainAxisSize,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon,
            const SizedBox(width: 8.0),
          ],
          Text(
            buttonTitle,
            style: textStyle ?? AppTextStyles.secondaryButtonTextStyle,
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 8.0),
            trailingIcon,
          ],
        ],
      ),
    );
  }
}
