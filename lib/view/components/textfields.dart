import 'package:flutter/material.dart';
import 'package:medoptic/Constants/colors.dart';
import 'package:medoptic/constants/decorations.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.controller,
      this.suffix,
      required this.hintText,
      this.prefixIcon,
      required this.keyboardType,
      this.obscureText = false});
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: CustomColors.contrastColor1,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.grey.shade400),
        counterStyle: const TextStyle(
          color: Colors.grey,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        enabledBorder: Decorations().enabledBorder,
        focusedBorder: Decorations().focusedBorder,
        errorBorder: Decorations().errorBorder,
        focusedErrorBorder: Decorations().focusedErrorBorder,
      ),
    );
  }
}
