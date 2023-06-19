import 'package:flutter/material.dart';

class ColorStyles {
  static const Color baseLightBlue = Color(0xffF8F4FB);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

extension PrimaryColors on ColorStyles {
  static const Color primaryBlue = Color(0xff4F5496);
  static const Color primaryDarkGray = Color(0xff303146);
  static const Color primaryGrayBlue = Color(0xff606172);
  static const Color primaryDarkBlue = Color(0xff404374);
}

extension SecondaryColor on ColorStyles {
  static const Color secondaryColor1 = Color(0xffE0A6B0);
  static const Color secondaryColor2 = Color(0xffCC9BAC);
  static const Color secondaryColor3 = Color(0xffCCCCCC);
}

extension TextColor on ColorStyles {
  static const Color textPrimary1 = Color(0xff4F5496);
  static const Color textPrimary2 = Color(0xff606172);
  static const Color textSecondary1 = Color(0xffE0A6B0);
  static const Color textSecondary2 = Color(0xffCC9BAC);
  static const Color textSecondary3 = Color(0xffE1CACD);
}

extension LogoColor on ColorStyles {
  static const Color logoBlue = Color(0xff4F5496);
  static const Color logoLightBlue = Color.fromARGB(127, 248, 244, 251);
  static const Color logoLightGreenGray = Color.fromARGB(127, 234, 172, 178);
}