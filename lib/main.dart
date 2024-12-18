import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medoptic/Constants/colors.dart';
import 'firebase_options.dart';
import 'view/routes/routing.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'medoptic',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: CustomColors.primaryColor,
        // primarySwatch: MaterialColor(primary, swatch),
        bottomSheetTheme: const BottomSheetThemeData(
          elevation: 0,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lexend(
            fontSize: 38,
            fontWeight: FontWeight.w600,
            color: CustomColors.contrastColor1,
          ),
          displaySmall: GoogleFonts.openSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColors.primaryColor,
          ),
          headlineLarge: GoogleFonts.roboto(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: CustomColors.fontColor1,
          ),
          headlineMedium: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headlineSmall: GoogleFonts.openSans(
            fontSize: 12,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: CustomColors.fontColor1,
          ),
          labelMedium: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          labelSmall: GoogleFonts.openSans(
            fontSize: 13,
            color: CustomColors.fontColor1,
          ),
        ),
      ),
    );
  }
}
