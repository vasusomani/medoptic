import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medoptic/model/user_model.dart';
import 'package:medoptic/services/state_management_services/templates_riverpod.dart';
import '../../../../Constants/colors.dart';
import '../../../../model/template_model.dart';
import '../../../../services/api_services/template_api.dart';
import '../../../../services/api_services/user_api.dart';
import '../../../../services/helper_functions/toast_util.dart';

import '../../../../services/firebase_services/phone_auth_service.dart';
import '../../../../services/state_management_services/user_riverpod.dart';
import '../../../components/buttons.dart';
import '../../../components/textfields.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  PhoneAuthService phoneAuthService = PhoneAuthService();
  bool isOTPSent = false;
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

  Future<Map<String, dynamic>?> checkUserExists() async {
    try {
      Map<String, dynamic>? responseBody = await UserApi().getUser();
      return responseBody;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> signInWithOTP() async {
    try {
      if (otpController.text.isNotEmpty &&
          otpController.text.length == 6 &&
          phoneController.text.isNotEmpty &&
          phoneController.text.length == 10) {
        await phoneAuthService.signInWithOTP(otpController.text);
        Map<String, dynamic>? responseBody = await checkUserExists();
        if (responseBody != null) {
          UserModel user = UserModel.fromJson(responseBody['data']);
          debugPrint(user.toJson().toString());
          ref.watch(userProvider.notifier).setUser(user);
          //Get all templates
          // List<dynamic>? templatesResponseBody =
          //     await TemplateApi().getAllTemplates();
          // if (templatesResponseBody != null) {
          //   List<Template> templates =
          //       templatesResponseBody.map((e) => Template.fromJson(e)).toList();
          //   ref.watch(templatesProvider).addAll(templates);
          // }
          if (user.templates != null) {
            ref.watch(templatesProvider).addAll(user.templates!);
          }
          Navigator.pushNamed(context, '/home');
        } else {
          ToastWidget.bottomToast(
              "Mobile number not registered. Please sign up first");
        }
      } else {
        ToastWidget.bottomToast("Please enter a valid OTP");
      }
    } catch (e) {
      debugPrint("signInWIthOTP Error : $e");
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
                          maxLength: 10,
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
                            onPressed: () {
                              signInWithOTP();
                            },
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
                        const SizedBox(
                          height: 30,
                        ),
                        SocialButton(
                          onPressed: () {},
                          isLogin: true,
                        ),
                        const SizedBox(
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
