import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class Decorations {
  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.grey.shade300),
    gapPadding: 10,
  );
  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: CustomColors.contrastColor1),
    gapPadding: 10,
  );
  OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 10,
  );
  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 10,
  );
}
