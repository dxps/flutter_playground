import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';

//
mixin UserModel on Model {
  //

  User authenticatedUser;

  void login(String email, String password) {
    authenticatedUser = User(id: '1234', email: email, password: password);
    print('[UserModel] login > authenticatedUser:${authenticatedUser.toJsonString()}');
  }
}
