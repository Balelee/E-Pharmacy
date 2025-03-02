import 'package:flutter/material.dart';
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
      defaultPinTheme: PinTheme(
        width: 40,
        height: 40,
        textStyle: TextStyle(fontSize: 20, color: Colors.black),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
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
