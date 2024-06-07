import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class Decorations {
  //Decoration 1
  OutlineInputBorder enabledBorder1 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.grey.shade300),
    gapPadding: 10,
  );
  OutlineInputBorder focusedBorder1 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: CustomColors.contrastColor1),
    gapPadding: 10,
  );
  OutlineInputBorder focusedErrorBorder1 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 10,
  );
  OutlineInputBorder errorBorder1 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 10,
  );

  //Decoration 2
  OutlineInputBorder enabledBorder2 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: Colors.grey.shade700),
    gapPadding: 10,
  );
  OutlineInputBorder focusedBorder2 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: CustomColors.contrastColor1),
    gapPadding: 10,
  );
  OutlineInputBorder focusedErrorBorder2 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 10,
  );
  OutlineInputBorder errorBorder2 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.red),
    gapPadding: 10,
  );
}
