import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pinput/pinput.dart';

class OTPFieldWidget extends StatelessWidget {
  final TextEditingController otpController;
  final Function(String) onCompleted;
  final int length;
  final PinTheme? defaultPinTheme;
  final bool useNativeKeyboard;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  const OTPFieldWidget(
      {super.key,
      required this.otpController,
      required this.onCompleted,
      required this.length,
      this.defaultPinTheme,
      this.useNativeKeyboard = true,
      this.obscureText = false,
      this.inputFormatters = const [],
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: otpController,
      length: length,
      useNativeKeyboard: useNativeKeyboard,
      obscureText: obscureText,
      defaultPinTheme: defaultPinTheme ??
          PinTheme(
            width: 40,
            height: 40,
            textStyle: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      errorPinTheme: defaultPinTheme?.copyWith(
        textStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.red, width: 3.0),
        ),
      ),
      onCompleted: onCompleted,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: (value) {},
    );
  }
}
