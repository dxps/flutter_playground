import 'package:flutter/material.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/widgets/login_header.dart';
import '../../core/viewmodels/login_model.dart';
import '../../core/enums/viewstate.dart';
import 'base_view.dart';

///
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

///
class _LoginViewState extends State<LoginView> {
  //
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                LoginHeader(validationMessage: model.errorMsg, controller: _controller),
                model.state == ViewState.Busy
                    ? CircularProgressIndicator()
                    : FlatButton(
                        color: Colors.white,
                        child: Text('Login', style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          if (await model.login(_controller.text)) Navigator.pushNamed(context, '/');
                        },
                      )
              ],
            ),
          ),
    );
  }
}
