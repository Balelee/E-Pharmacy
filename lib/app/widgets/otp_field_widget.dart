import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OTPFieldWidget extends StatelessWidget {
  final TextEditingController otpController;
  final Function(String) onCompleted;
  const OTPFieldWidget({
    super.key,
    required this.otpController,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: otpController,
      length: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      defaultPinTheme: PinTheme(
        width: 40,
        height: 40,
        textStyle: TextStyle(fontSize: 20, color: Colors.black),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onCompleted: onCompleted,
      onChanged: (value) {
        if (value.length == 6) {
          onCompleted(value);
        }
      },
    );
  }
}
