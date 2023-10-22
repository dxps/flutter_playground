import 'package:flutter_stacked_web_landing/app/app.dialogs.dart';
import 'package:flutter_stacked_web_landing/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FormViewModel {
  final _dialogService = locator<DialogService>();

  void captureEmail() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Thanks for Signing Up',
      // TODO: TBD how to get that $emailValue as an inherited.
      // description: 'Check in $emailValue Value for a verification email',
      description: 'Check your email for a confirmation',
    );
  }
}
