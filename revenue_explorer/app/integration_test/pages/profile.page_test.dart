import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:revenue_explorer/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("RevExProfilePage", () {
    testWidgets("appears when the Profile icon is clicked", (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(seconds: 2));

      final emailInput = find.byWidgetPredicate((widget) =>
          widget is TextField &&
          widget.keyboardType == TextInputType.emailAddress);
      expect(emailInput, findsOneWidget);

      await tester.enterText(emailInput, "joe@doe.com");

      final passwordInput = find.byWidgetPredicate((widget) =>
          widget is TextField &&
          widget.keyboardType == TextInputType.visiblePassword);
      expect(passwordInput, findsOneWidget);

      await tester.enterText(passwordInput, "joe");
      await tester.pump(const Duration(seconds: 1));

      final loginButton = find.widgetWithText(ElevatedButton, "Log In");
      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      final profileButton = find.byTooltip("My Profile");
      await tester.tap(profileButton);

      await tester.pumpAndSettle();

      expect(find.text("jthorms"), findsOneWidget);
    });
  });
}
