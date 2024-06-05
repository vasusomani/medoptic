import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.widget,
      this.isContrast = false,
      this.isLoading = false});
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget? widget;
  final bool isContrast;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: (isContrast)
            ? CustomColors.contrastColor2
            : CustomColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: (isLoading)
              ? const FittedBox(
                  child: CupertinoActivityIndicator(color: Colors.white))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(text, style: Theme.of(context).textTheme.labelMedium),
                    if (widget != null) ...[SizedBox(width: 15), widget!]
                  ],
                )),
    );
  }
}

class SocialButton extends StatelessWidget {
  SocialButton({
    super.key,
    this.isApple = false,
    this.prefix,
    required this.onPressed,
    this.isLoading = false,
    this.isLogin = false,
  });
  final bool isApple;
  final Icon? prefix;
  final Function()? onPressed;
  final bool isLoading;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                  width: 0.5, color: CustomColors.contrastColor2),
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          elevation: const MaterialStatePropertyAll(1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: (isLoading)
              ? const SizedBox(
                  height: 23,
                  width: 23,
                  child: CupertinoActivityIndicator(
                      animating: true, color: CustomColors.contrastColor2))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefix != null) prefix!,
                    if (prefix == null)
                      SvgPicture.asset(
                          (isApple)
                              ? 'assets/images/apple.svg'
                              : 'assets/images/google.svg',
                          height: (isApple) ? 20 : 20,
                          color: (isApple) ? Colors.black : null),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(
                          "Sign ${isLogin ? "in" : "up"} with ${prefix != null ? "Email and Password" : (isApple) ? "Apple" : "Google"}",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: CustomColors.contrastColor2,
                                  )),
                    ),
                  ],
                ),
        ));
  }
}
