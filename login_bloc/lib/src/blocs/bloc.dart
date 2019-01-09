import 'dart:async';
import 'validators.dart';

/// BLoC of the application.
class Bloc extends Validators {
  //

  final _emailCtrl = StreamController<String>();
  final _passwordCtrl = StreamController<String>();

  /// Consumer of email updates.
  Stream<String> get email => _emailCtrl.stream.transform(validateEmail);

  /// Producer of email changes.
  Function(String) get changeEmail => _emailCtrl.sink.add;

  // Consumer of entered password updates.
  Stream<String> get password => _passwordCtrl.stream.transform(validatePassword);

  /// Producer of entered password changes.
  Function(String) get changePassword => _passwordCtrl.sink.add;

  dispose() {
    _emailCtrl.close();
    _passwordCtrl.close();
  }
}

/// The singleton instance used by LoginScreen.
final bloc = Bloc();
