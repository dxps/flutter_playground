import 'package:flutter/material.dart';

import '../data/user_data.dart';
import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    // This would be either passed from the previous page or fetched from a provider/state management solution.
    // For simplicity, we're using a global variable here.
    var currUser = user ?? currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), leading: BackButton()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person_outlined, size: 80)),
            const SizedBox(height: 20),
            Text(currUser.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(currUser.email),
          ],
        ),
      ),
    );
  }
}
