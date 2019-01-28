import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  //
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  //

  Map<String, dynamic> _formData = {'email': 'test@test.com', 'password': 'pass123'};
  bool _acceptTerms = true;
  String _acceptTermsFormError = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //
  @override
  Widget build(BuildContext context) {
    //
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550 ? 400.0 : deviceWidth * 0.9;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        padding: EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Column(
                children: <Widget>[
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[_buildEmailField(), SizedBox(height: 10.0), _buildPasswordField()],
                      )),
                  _buildAcceptSwitch(),
                  SizedBox(height: 10),
                  ScopedModelDescendant<MainModel>(
                    builder: (BuildContext ctx, Widget child, MainModel model) {
                      return RaisedButton(
                        child: Text('Login'),
                        onPressed: () => _submitForm(model.login),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //
  void _submitForm(Function login) {
    //
    if (!_formKey.currentState.validate() || !_acceptTerms) {
      if (!_acceptTerms) setState(() => _reviewAcceptTerms(_acceptTerms));
      return;
    }
    _formKey.currentState.save();
    login(_formData['email'], _formData['password']);
    Navigator.pushReplacementNamed(context, '/home');
  }

  //
  DecorationImage _buildBackgroundImage() {
    //
    return DecorationImage(
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      fit: BoxFit.cover,
      image: AssetImage('assets/background.jpg'),
    );
  }

  //
  Widget _buildEmailField() {
    //
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: Colors.white.withOpacity(0.9)),
      keyboardType: TextInputType.emailAddress,
      maxLength: 64,
      initialValue: _formData['email'],
      onSaved: (String value) => _formData['email'] = value,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Email is required and must be a valid';
        }
      },
    );
  }

  //
  Widget _buildPasswordField() {
    //
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white.withOpacity(0.9)),
      maxLength: 64,
      obscureText: true,
      initialValue: _formData['password'],
      onSaved: (String value) => _formData['password'] = value,
      validator: (String value) {
        if (value.isEmpty) return 'Password is required';
      },
    );
  }

  //
  Widget _buildAcceptSwitch() {
    //
    return Column(
      children: <Widget>[
        SwitchListTile(
          value: _acceptTerms,
          onChanged: (bool value) {
            debugPrint('[AuthPage] switch onChanged > value=$value');
            setState(() => _reviewAcceptTerms(value));
            debugPrint('[AuthPage] _acceptTerms=$_acceptTerms _acceptTermsFormError=$_acceptTermsFormError');
          },
          title: Text('Accept Terms', style: TextStyle(color: Colors.black)),
        ),
        Text(_acceptTermsFormError, style: TextStyle(color: Colors.red, fontSize: 12))
      ],
    );
  }

  //
  void _reviewAcceptTerms(bool value) {
    _acceptTerms = value;
    _acceptTermsFormError = value ? '' : 'You need to accept the terms';
  }
}
