import 'package:flutter/material.dart';

import '../theme/theme_ctrl.dart';
import '../theme/theme_type.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.theme == AppTheme.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Light / Dark Theme'),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose a theme',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),

                SegmentedButton<AppTheme>(
                  segments: const [
                    ButtonSegment<AppTheme>(
                      value: AppTheme.light,
                      icon: Icon(Icons.light_mode),
                      label: Text('Light'),
                    ),
                    ButtonSegment<AppTheme>(
                      value: AppTheme.dark,
                      icon: Icon(Icons.dark_mode),
                      label: Text('Dark'),
                    ),
                  ],
                  selected: {themeController.theme},
                  onSelectionChanged: (selection) {
                    themeController.setTheme(selection.first);
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Dark mode'),
                    const SizedBox(width: 12),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        themeController.setTheme(
                          value ? AppTheme.dark : AppTheme.light,
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  'Current theme: ${isDark ? 'Dark' : 'Light'}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
