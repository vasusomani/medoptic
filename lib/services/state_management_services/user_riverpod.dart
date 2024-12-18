import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  setUser(UserModel? user) {
    if (user != null) {
      state = user;
      debugPrint("UserNotifier: ${state!.name}");
    }
  }

  removeUser() {
    state = null;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
