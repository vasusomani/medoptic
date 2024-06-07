import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../../../model/user_model.dart';
import '../local_storage_services/secure_storage.dart';

class HandleLogin {
  final String USER_DATA_KEY = "USER_DATA";

  Future getLoginDetails() async {
    try {
      String? user = await SecureStorageService().readSecureData(USER_DATA_KEY);
      if (user != null && user.isNotEmpty && user != "null") {
        log("User data found");
        debugPrint("User Data $user");
        UserModel userModel = UserModel.fromJson(json.decode(user));
        return userModel;
      } else {
        log("User data not found");
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future saveLoginDetails(UserModel? user) async {
    try {
      await SecureStorageService()
          .writeSecureData(USER_DATA_KEY, jsonEncode(user?.toJson()));
      log("User data saved");
      return true;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future deleteLoginDetails() async {
    try {
      await SecureStorageService().deleteSecureData(USER_DATA_KEY);
      log("User data deleted");
      return true;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
