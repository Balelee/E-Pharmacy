import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static Widget primaryButton({
    required void Function()? onPressed,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Widget? leadingIcon,
    Widget? trailingIcon,
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
        backgroundColor: backgroundColor ?? const Color(0xFF28722B),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        elevation: elevation ?? 2.0, // Default elevation if not provided
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
        foregroundColor: textColor ?? Colors.blue, padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
