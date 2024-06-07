import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medoptic/services/helper_functions/toast_util.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId; // Store verification ID

  //Google SignIn
  Future<void> phoneAuth(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          debugPrint("Verification Completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
          ToastWidget.bottomToast(e.message.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId; // Save verification ID
          debugPrint("Code Sent");
          ToastWidget.bottomToast("Code Sent Successfully");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId; // Save verification ID
          debugPrint("Code Auto Retrieval Timeout");
          // ToastWidget.bottomToast("Code Auto Retrieval Timeout");
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      ToastWidget.bottomToast(e.message.toString());
      rethrow;
    }
  }

  Future<void> signInWithOTP(String smsCode) async {
    try {
      if (_verificationId != null) {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: smsCode);
        await _auth.signInWithCredential(phoneAuthCredential);
        debugPrint("OTP Verified");
      } else {
        throw Exception("Verification ID is null. Please request a new OTP.");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      ToastWidget.bottomToast(e.message.toString());
      rethrow;
    }
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
