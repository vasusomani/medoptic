import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medoptic/Constants/colors.dart';

import '../../../components/buttons.dart';
import '../../../components/textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOTPSent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            gradient: CustomColors.primaryGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "MedOptic",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 27, color: Colors.white.withOpacity(0.95)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Welcome Back!",
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: 4),
                        Text("Please sign in to access your chemist account.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      CustomColors.fontColor1.withOpacity(0.7),
                                )),
                        const SizedBox(height: 40),
                        AuthTextField(
                          controller: phoneController,
                          hintText: "Phone Number",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey.shade500,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          controller: otpController,
                          hintText: "OTP for verification",
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: Colors.grey.shade500,
                          ),
                          suffix: TextButton(
                            onPressed: () {
                              setState(() {
                                isOTPSent = !isOTPSent;
                                //TODO
                                //send OTP and start timer
                              });
                            },
                            child: Text(
                              isOTPSent ? "Resend OTP" : "Send OTP",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: CustomColors.contrastColor1,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        //forgot password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: CustomColors.contrastColor2,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.maxFinite,
                          child: PrimaryButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/home'),
                            text: "Sign In",
                            isContrast: true,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                                endIndent: 10,
                              ),
                            ),
                            Text(
                              "Or",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey.shade500),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SocialButton(
                          onPressed: () {},
                          isLogin: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SocialButton(
                          onPressed: () {},
                          isApple: true,
                          isLogin: true,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height * 0.07,
                              bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      color: CustomColors.fontColor1
                                          .withOpacity(0.7),
                                    ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/signup'),
                                child: Text(
                                  "Create Now",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.primaryColor,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
