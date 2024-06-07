import 'package:flutter/material.dart';
import 'package:medoptic/Constants/colors.dart';

import '../../../components/buttons.dart';
import '../../../components/textfields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController medicNameController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
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
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                        Text("Create Account",
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: 10),
                        Text(
                            "Don't worry we take your privacy seriously, so your information is secure.",
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
                          controller: medicNameController,
                          hintText: "Full Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey.shade500,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          controller: storeNameController,
                          hintText: "Store Name",
                          prefixIcon: Icon(
                            Icons.medical_services_rounded,
                            color: Colors.grey.shade500,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
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
                          obscureText: true,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          controller: storeAddressController,
                          hintText: "Store Address (Optional)",
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.grey.shade500,
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.maxFinite,
                          child: PrimaryButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/home'),
                            text: "Sign Up",
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
                        const SizedBox(
                          height: 30,
                        ),
                        SocialButton(
                          onPressed: () {},
                          isLogin: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SocialButton(
                          onPressed: () {},
                          isApple: true,
                          isLogin: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
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
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Sign In",
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
