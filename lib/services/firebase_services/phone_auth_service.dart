import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medoptic/services/api_services/user_api.dart';
import 'package:medoptic/services/helper_functions/toast_util.dart';

class PhoneAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  int? _resendToken;

  //Google SignIn
  Future<void> phoneAuth(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(seconds: 25),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          resendToken = resendToken;
          debugPrint("Code Sent");
          ToastWidget.bottomToast("Code Sent Successfully");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          debugPrint("Code Auto Retrieval Timeout");
        },
        forceResendingToken: _resendToken,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      ToastWidget.bottomToast(e.message.toString());
      rethrow;
    }
  }

  Future<String?> signInWithOTP(String smsCode) async {
    try {
      if (_verificationId != null) {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: smsCode,
        );
        await _auth.signInWithCredential(phoneAuthCredential);
        debugPrint("OTP Verified");
        String? idToken = await _auth.currentUser?.getIdToken(true);
        debugPrint("Id Token : $idToken");
        return idToken;
      } else {
        throw Exception("Verification ID is null. Please request a new OTP.");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      if (e.code == "invalid-verification-code") {
        ToastWidget.bottomToast("Invalid OTP");
      } else {
        ToastWidget.bottomToast(e.message.toString());
      }
      debugPrint(e.code);
      rethrow;
    }
  }

  //Get ID token
  static Future<String?> getIdToken() async {
    try {
      String? idToken = await _auth.currentUser?.getIdToken(true);
      debugPrint("Id Token : $idToken");
      return idToken;
    } on FirebaseAuthException catch (e) {
      debugPrint("Error in getting ID Token");
      debugPrint(e.message.toString());
    }
    return null;
  }

  //SignOut
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
