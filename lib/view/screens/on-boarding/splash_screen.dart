import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medoptic/view/components/buttons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   Future.delayed(Duration(milliseconds: 1000))
  //       .then((value) => Navigator.pushNamed(context, '/login'));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: MediaQuery.sizeOf(context).width * 0.5,
              width: MediaQuery.sizeOf(context).width * 0.5,
            ),
            const SizedBox(height: 30),
            Text(
              "MedOptic",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: Text(
                "Beyond limitations, beyond dependence.",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.12),
        child: PrimaryButton(
          onPressed: () => Navigator.pushNamed(context, '/login'),
          text: "Continue",
          widget: Transform.rotate(
            angle: pi,
            child: SvgPicture.asset(
              'assets/icons/Arrow1.svg',
              height: 21,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
