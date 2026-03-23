import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'validators.dart';

/// BLoC of the application.
class Bloc extends Validators {
  //

  final _emailStreamCtrl = BehaviorSubject<String>();
  final _passwordStreamCtrl = BehaviorSubject<String>();

  // __________ email __________

  /// Consumer of email updates.
  Stream<String> get email => _emailStreamCtrl.stream.transform(validateEmail);

  /// Producer of email changes.
  Function(String) get changeEmail => _emailStreamCtrl.sink.add;

  // __________ password __________

  /// Consumer of entered password updates.
  Stream<String> get password => _passwordStreamCtrl.stream.transform(validatePassword);

  /// Producer of entered password changes.
  Function(String) get changePassword => _passwordStreamCtrl.sink.add;

  // __________ submit __________

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  submit() {
    final validEmail = _emailStreamCtrl.value;
    final validPassword = _passwordStreamCtrl.value;
    print('submit > validEmail=$validEmail validPassword=$validPassword');
  }

  // ________________________________________

  dispose() {
    _emailStreamCtrl.close();
    _passwordStreamCtrl.close();
  }
}
