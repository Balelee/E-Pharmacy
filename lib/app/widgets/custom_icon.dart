import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon {
    static Widget socialMedia(
      {required String localPath, double? width, double? height}) {
    return SvgPicture.asset(
      localPath,
      width: width,
      height: height,
    );
  }
}