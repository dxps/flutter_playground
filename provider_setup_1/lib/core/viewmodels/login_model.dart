import 'package:flutter/cupertino.dart';

import '../viewmodels/base_model.dart';
import '../services/auth_svc.dart';
import '../../locator.dart';

/// Login's viewmodel.
class LoginModel extends BaseModel {
  //
  final AuthenticationService _authSvc = locator<AuthenticationService>();
  String errorMsg;

  Future<bool> login(String userIdTxt) async {
    setState(ViewState.Busy);
    var userId = int.tryParse(userIdTxt);
    if (userId == null) {
      errorMsg = 'Provided value \'$userIdTxt\' is not a number';
      debugPrint('LoginModel login > $errorMsg');
      setState(ViewState.Idle);
      return false;
    }
    errorMsg = null;
    var success = await _authSvc.login(userId);
    setState(ViewState.Idle);
    return success;
  }
  //
}
