import 'package:flutter/material.dart';

class MainButton {
  static Widget mainButton({
    required void Function()? onPressed,
    Color? overlayColor,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Widget? leadingIcon,
    Widget? trailingIcon,
    required String buttonTile,
    TextStyle? textStyle,
    TextStyle? leadingIconStyle,
    TextStyle? trailingIconStyle,
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
            buttonTile,
            style: textStyle ??
                TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: fontSize ?? 18.0,
                  fontWeight: textFontWeight ?? FontWeight.w700,
                ),
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
