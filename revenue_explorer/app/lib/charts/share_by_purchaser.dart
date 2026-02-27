import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../http/transaction.http.dart';

class RevExShareByPurchaserChart extends StatelessWidget {
  final List<RevExTransaction> transactions;

  const RevExShareByPurchaserChart(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    var orderedPurchasers = getOrderedPurchasers(transactions);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text("Transaction volume by purchaser"),
        ),
        Expanded(
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sections: orderedPurchasers
                  .map(
                    (entry) => PieChartSectionData(
                      value: entry.value,
                      title:
                          '${entry.key}\n${NumberFormat.compactSimpleCurrency().format(entry.value)}',
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                  .toList(),
              startDegreeOffset: -90,
            ),
          ),
        ),
      ],
    );
  }

  static Iterable<MapEntry<String, double>> getOrderedPurchasers(
    List<RevExTransaction> transactions,
  ) {
    final amountsByPurchaser = transactions
        .groupListsBy((tx) => tx.purchaserName)
        .map((key, value) => MapEntry<String, double>(
            key, value.fold(0, (previous, tx) => previous + tx.amount)));
    final orderedPurchasers = amountsByPurchaser.entries
        .sortedBy<num>((entry) => entry.value)
        .reversed;
    return orderedPurchasers;
  }
}
