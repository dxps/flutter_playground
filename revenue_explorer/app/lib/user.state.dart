import 'package:flutter/material.dart';
import 'package:revenue_explorer/http/http.dart';
import 'package:revenue_explorer/http/user.http.dart';

class RevExUserState extends ChangeNotifier {
  Future<RevExUser>? user;

  Future<void> loadUser(BuildContext context) async {
    if (user == null) {
      user = revExGetUser.authorize(context);
      Future(() => notifyListeners());
    }
  }

  void unloadUser() {
    user = null;
    notifyListeners();
  }
}
