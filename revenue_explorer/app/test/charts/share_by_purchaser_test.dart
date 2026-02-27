import 'package:flutter_test/flutter_test.dart';
import 'package:revenue_explorer/charts/share_by_purchaser.dart';
import 'package:revenue_explorer/http/transaction.http.dart';

void main() {
  group('RevExShareByPurchaserChart', () {
    test('handles an empty list of transactions', () {
      final result = RevExShareByPurchaserChart.getOrderedPurchasers([]);
      expect(result.length, 0);
    });

    test('sorts and categorizes a list of transactions', () {
      final transactions = <RevExTransaction>[
        RevExTransaction(
            id: 0,
            purchaserName: 'Test Alice',
            purchaseDate: "00/00/00",
            amount: 10,
            productCode: "Test A"),
        RevExTransaction(
            id: 1,
            purchaserName: 'Test Alice',
            purchaseDate: "00/00/00",
            amount: 10,
            productCode: "Test B"),
        RevExTransaction(
            id: 2,
            purchaserName: 'Test Bob',
            purchaseDate: "00/00/00",
            amount: 10,
            productCode: "Test C"),
      ];

      final result =
          RevExShareByPurchaserChart.getOrderedPurchasers(transactions)
              .toList();

      expect(result.length, 2);

      expect(result[0].key, 'Test Alice');
      expect(result[0].value, 20);

      expect(result[1].key, 'Test Bob');
      expect(result[1].value, 10);
    });
  });
}
