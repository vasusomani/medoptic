import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:medoptic/services/firebase_services/phone_auth_service.dart';

class UserApi {
  final String baseUrl = dotenv.env['BASE_URL']!;

  //Create User Api
  Future createUser({
    required String name,
    required String storeName,
    required String storeAddress,
  }) async {
    try {
      final body = jsonEncode({
        'name': name,
        'storeName': storeName,
        'storeAddress': storeAddress,
      });
      final url = Uri.parse('$baseUrl/user/register');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        debugPrint("SIGNUP RESPONSE ${response.body}");
        log("Signup Success");
        return jsonDecode(response.body);
      } else {
        log("Signup Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log("Signup Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  //Get User Api
  Future getUser() async {
    try {
      final url = Uri.parse('$baseUrl/user/getUserInfo');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        debugPrint("GET USER RESPONSE ${response.body}");
        log("Get User Success");
        return jsonDecode(response.body);
      } else {
        log("Get User Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log("Get User Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  //Update User Api
  Future updateUser({
    required String name,
    required String storeName,
    required String storeAddress,
  }) async {
    try {
      final body = jsonEncode({
        'name': name,
        'storeName': storeName,
        'storeAddress': storeAddress,
      });
      final url = Uri.parse('$baseUrl/user/updateUserInfo');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        debugPrint("UPDATE USER RESPONSE ${response.body}");
        log("Update User Success");
        return jsonDecode(response.body);
      } else {
        log("Update User Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw 'Failed to update user, please try again later';
      }
    } catch (e) {
      log("Update User Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  //Delete User Api
  Future deleteUser() async {
    try {
      final url = Uri.parse('$baseUrl/user/deleteUser');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.delete(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        debugPrint("DELETE USER RESPONSE ${response.body}");
        log("Delete User Success");
        return jsonDecode(response.body);
      } else {
        log("Delete User Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw 'Failed to delete user, please try again later';
      }
    } catch (e) {
      log("Delete User Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }
}
