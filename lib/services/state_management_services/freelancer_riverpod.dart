import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  setFreelancer(UserModel? user) {
    state ??= user;
  }

  removeFreelancer() {
    state = null;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
