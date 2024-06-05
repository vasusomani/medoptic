import 'package:flutter/material.dart';
import 'package:medoptic/view/screens/home/main_screen.dart';

import '../screens/home/scanner_screen.dart';
import '../screens/on-boarding/auth/login_screen.dart';
import '../screens/on-boarding/auth/signup_screen.dart';
import '../screens/on-boarding/splash_screen.dart';

class RouteGenerator extends NavigatorObserver {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
