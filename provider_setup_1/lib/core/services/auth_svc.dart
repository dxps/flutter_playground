import 'dart:async';

import 'package:provider_setup_1/core/models/user.dart';
import 'package:provider_setup_1/locator.dart';

import '../../core/services/api.dart';

///
class AuthenticationService {
  //
  Api _api = locator<Api>(); // inject the api

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(int userId) async {
    // Not real login, we'll just request the user profile.
    var user = await _api.getUserProfile(userId);
    var hasUser = user != null;
    if (hasUser) userController.add(user);
    return hasUser;
  }
  //
}
