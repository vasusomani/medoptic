import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryColor = Color(0xFF58D8FF);
  static const Color primaryLightColor = Color(0xFFD8EAFC);
  static const Color secondaryColor = Color(0xFF00CBFF);
  static const Color contrastColor1 = Color(0xFF218eed);
  static const Color contrastColor2 = Color(0xFF2A4A64);
  static const Color toastColor = Color(0xFF525252);
  static const Color fontColor1 = Color(0xFF3d3f40);
  static const Color fontColor2 = Color(0xFFFFFFFF);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [contrastColor2, contrastColor1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
