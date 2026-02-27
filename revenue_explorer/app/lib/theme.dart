import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class RevexTheme implements AppThemeOptions {
  final String name;
  final String description;
  final Brightness brightness;
  final Color primary;
  final Color primaryText;
  final Color secondary;
  final Color secondaryText;
  final Color danger;
  final Color dangerText;

  const RevexTheme(
    this.name,
    this.description, {
    required this.brightness,
    required this.primary,
    required this.primaryText,
    required this.secondary,
    required this.secondaryText,
    required this.danger,
    required this.dangerText,
  });

  AppTheme get appTheme {
    return AppTheme(
      id: name,
      description: description,
      data: ThemeData(
        brightness: brightness,
        cardTheme: CardThemeData(
          color: primary,
          elevation: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
              width: 1,
            ),
          ),
        ),
        colorSchemeSeed: primary,
        typography: Typography.material2021(),
        useMaterial3: true,
      ),
      options: this,
    );
  }
}

final revexLightTheme = RevexTheme(
  "light",
  "Light Theme (Default)",
  brightness: Brightness.light,
  primary: Colors.green,
  primaryText: Colors.black,
  secondary: Colors.purple,
  secondaryText: Colors.white,
  danger: Colors.red.shade600,
  dangerText: Colors.white,
);

extension GetThemeOptionsEx on BuildContext {
  RevexTheme get theme {
    return ThemeProvider.optionsOf<RevexTheme>(this);
  }
}
