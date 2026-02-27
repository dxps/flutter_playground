import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revenue_explorer/http/auth.http.dart';
import 'package:revenue_explorer/theme.dart';

final _emailRegex = RegExp(r"[^\s]+\@[^\s]+\.[^\s]+");

class RevExLoginOverlay extends StatefulWidget {
  const RevExLoginOverlay({super.key});

  @override
  State<RevExLoginOverlay> createState() => _RevExLoginOverlayState();
}

class _RevExLoginOverlayState extends State<RevExLoginOverlay> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isValid = false;

  bool isEmailValid() {
    final email = _emailController.text;
    return email.trim().isNotEmpty && _emailRegex.hasMatch(email);
  }

  bool isPasswordValid() {
    final password = _passwordController.text;
    return password.isNotEmpty;
  }

  void checkFormValidity() {
    setState(() {
      isValid = isEmailValid() && isPasswordValid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            color: context.theme.appTheme.data.dialogBackgroundColor,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "Please log in to continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  autocorrect: false,
                  controller: _emailController,
                  decoration: InputDecoration(
                    errorText: isEmailValid() || _emailController.text.isEmpty
                        ? null
                        : "Please enter a valid email address.",
                    isDense: true,
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) {
                    checkFormValidity();
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: "Password",
                  ),
                  enableSuggestions: false,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (_) {
                    checkFormValidity();
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: isValid
                    ? () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final success = await revExLogIn(
                            _emailController.text, _passwordController.text);

                        if (!success && messenger.mounted) {
                          messenger.showSnackBar(const SnackBar(
                            content: Text(
                              "Login failed. Please check your login details and try again.",
                            ),
                          ));
                        }

                        if (success && context.mounted) {
                          context.pop();
                        }
                      }
                    : null,
                child: const Text("Log In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
