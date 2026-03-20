import 'package:flutter/material.dart';
import 'package:flutter_go_router_example/data/user_data.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, you would fetch the user data from a provider or state management solution.
    var user = currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Page', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            FilledButton(
              // This works, but it won't change the URL in the browser.
              // Thus, deep linking (or refresh on that page) won't work.
              // onPressed: () => context.push(Routes.nestedProfilePage, extra: user),
              onPressed: () => context.go(Routes.nestedProfilePage, extra: user),
              child: const Text('View Profile Page'),
            ),
          ],
        ),
      ),
    );
  }
}
