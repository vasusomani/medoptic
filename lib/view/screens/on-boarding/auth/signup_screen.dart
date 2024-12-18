import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medoptic/Constants/colors.dart';

import '../../../../services/api_services/user_api.dart';
import '../../../../services/firebase_services/phone_auth_service.dart';
import '../../../../services/helper_functions/toast_util.dart';
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
  PhoneAuthService phoneAuthService = PhoneAuthService();
  bool isOTPSent = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _start = 0;

  void startTimer() {
    _start = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> sendOtp() async {
    try {
      await phoneAuthService.phoneAuth(phoneController.text);
      startTimer();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signUpWithOTP() async {
    try {
      if (!_formKey.currentState!.validate()) {
        ToastWidget.bottomToast(
            "Please fill all the required fields correctly");
        return;
      } else {
        final Map<String, dynamic> responseBody = await UserApi().createUser(
          name: medicNameController.text,
          storeName: storeNameController.text,
          storeAddress: storeAddressController.text,
        );
        debugPrint("Response Body : $responseBody");
        debugPrint("User Created Successfully");
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      debugPrint("signInWIthOTP Error 1: $e");
      ToastWidget.bottomToast(e.toString());
    }
  }

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
                    child: Form(
                      key: _formKey,
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
                                    color: CustomColors.fontColor1
                                        .withOpacity(0.7),
                                  )),
                          const SizedBox(height: 40),
                          AuthTextField(
                            controller: medicNameController,
                            hintText: "Full Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your store name";
                              }
                              return null;
                            },
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
                            maxLength: 10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your phone number";
                              } else if (value.length != 10) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the OTP";
                              }
                              return null;
                            },
                            maxLength: 6,
                            prefixIcon: Icon(
                              Icons.numbers,
                              color: Colors.grey.shade500,
                            ),
                            suffix: TextButton(
                              onPressed: _start == 0
                                  ? () {
                                      if (phoneController.text.isNotEmpty &&
                                          phoneController.text.length == 10) {
                                        sendOtp();
                                        setState(() {
                                          isOTPSent = true;
                                        });
                                      } else {
                                        ToastWidget.bottomToast(
                                            "Enter a valid phone number");
                                      }
                                    }
                                  : null,
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                              child: Text(
                                _start == 0
                                    ? (isOTPSent ? "Resend OTP" : "Send OTP")
                                    : '$_start sec',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: (_start == 0)
                                          ? CustomColors.contrastColor1
                                          : (Colors.grey.shade700),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
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
                              onPressed: () => signUpWithOTP(),
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
                ),
              )
            ],
          )),
    );
  }
}
