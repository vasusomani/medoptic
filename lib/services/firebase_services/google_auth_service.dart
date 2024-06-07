import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medoptic/model/user_model.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Google SignIn
  Future<UserModel?> googleAuth() async {
    final GoogleSignIn gSignIn = GoogleSignIn(scopes: ['profile', 'email']);
    try {
      final GoogleSignInAccount? gUser = await gSignIn.signIn();
      if (gUser == null) return null;
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential gCredential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(gCredential);

      debugPrint(userCredential.user!.displayName);
      debugPrint(userCredential.user!.email!);
      debugPrint(gAuth.accessToken!);
      UserModel? user;
      try {
        // user = await AuthService().login(
        //   email: userCredential.user!.email!,
        //   isSocialAuth: true,
        // );
      } catch (e) {
        debugPrint(e.toString());
        if (e.toString().contains("Email Id does not exists")) {
          debugPrint("Email Id does not exists");
          user = null;
        } else {
          rethrow;
        }
      }
      if (user != null) {
        debugPrint("Account already exists");
        return user;
      } else {
        debugPrint(user.toString());
        try {
          debugPrint("Creating an account");
          final UserCredential userCredential =
              await _auth.signInWithCredential(gCredential);
          // String randomUsername = userCredential.user!.displayName!
          //         .split(' ')[0] +
          //     DateTime.now().millisecondsSinceEpoch.toString().substring(5, 10);
          // debugPrint(randomUsername);
          // user = await AuthService().signUpEmail(
          //   email: userCredential.user!.email!,
          //   password: randomPassword,
          //   firstName: userCredential.user!.displayName!.split(' ')[0],
          //   lastName: (userCredential.user!.displayName!.split(' ').length > 1)
          //       ? userCredential.user!.displayName!.split(' ')[1]
          //       : "null",
          //   userName: randomUsername,
          //   phoneNumber: userCredential.user!.phoneNumber ?? "null",
          // );
          return user;
        } catch (e) {
          debugPrint(e.toString());
          rethrow;
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  //SignOut
  signOut() async {
    try {
      GoogleSignIn().signOut();
      _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
