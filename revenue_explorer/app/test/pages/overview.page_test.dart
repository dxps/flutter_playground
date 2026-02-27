import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:revenue_explorer/http/transaction.http.dart';
import 'package:revenue_explorer/pages/overview.page.dart';
import 'package:revenue_explorer/transactions.state.dart';

void main() {
  group('RevExOverviewPage', () {
    testWidgets('handles an empty list of transactions', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1170, 2532));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final transactionState = RevExTransactionsState()
        ..transactions = Future.value(<RevExTransaction>[]);
      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider.value(
          value: transactionState,
          builder: (_, __) => const RevExOverviewPage(),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(PaginatedDataTable), findsOneWidget);

      for (final column in ["Purchaser", "Amount", "Date", "Product Code"]) {
        expect(find.text(column), findsOneWidget);
      }
    });
  });
}
